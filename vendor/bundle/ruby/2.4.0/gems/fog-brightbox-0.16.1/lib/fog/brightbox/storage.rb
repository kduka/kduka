module Fog
  module Storage
    class Brightbox < Fog::Service
      requires :brightbox_client_id,
               :brightbox_secret
      recognizes :persistent, :brightbox_service_name,
                 :brightbox_storage_url,
                 :brightbox_service_type, :brightbox_tenant,
                 :brightbox_region, :brightbox_temp_url_key,
                 :brightbox_storage_management_url

      model_path "fog/brightbox/models/storage"
      model :directory
      collection :directories
      model :file
      collection :files

      request_path "fog/brightbox/requests/storage"
      request :copy_object
      request :delete_container
      request :delete_object
      request :delete_multiple_objects
      request :delete_static_large_object
      request :get_container
      request :get_containers
      request :get_object
      request :get_object_http_url
      request :get_object_https_url
      request :head_container
      request :head_containers
      request :head_object
      request :post_set_meta_temp_url_key
      request :put_container
      request :put_dynamic_obj_manifest
      request :put_object
      request :put_object_manifest
      request :put_static_obj_manifest

      class Mock
        def initialize(_options = {})
        end
      end

      class Real
        def initialize(config)
          if config.respond_to?(:config_service?) && config.config_service?
            @config = config
          else
            @config = Fog::Brightbox::Config.new(config)
          end
          @config = Fog::Brightbox::Storage::Config.new(@config)

          @temp_url_key = @config.storage_temp_key
        end

        def needs_to_authenticate?
          @config.must_authenticate?
        end

        def authentication_url
          @auth_url ||= URI.parse(@config.storage_url.to_s)
        end

        def management_url
          @config.storage_management_url
        end

        def reload
          @connection.reset
        end

        def account
          @config.account
        end

        def change_account(account)
          @config.change_account(account)
        end

        def reset_account_name
          @config.reset_account
        end

        def connection
          @connection ||= Fog::Brightbox::Storage::Connection.new(@config)
        end

        def request(params, parse_json = true)
          authenticate if @config.must_authenticate?
          connection.request(params, parse_json)
        rescue Fog::Brightbox::Storage::AuthenticationRequired => error
          if @config.managed_tokens?
            @config.expire_tokens!
            authenticate
            retry
          else # bad credentials
            raise error
          end
        rescue Excon::Errors::HTTPStatusError => error
          raise case error
                when Excon::Errors::NotFound
                  Fog::Storage::Brightbox::NotFound.slurp(error)
                else
                  error
                end
        end

        def authenticate
          if !management_url || needs_to_authenticate?
            response = Fog::Brightbox::Storage::AuthenticationRequest.new(@config).authenticate
            if response.nil?
              return false
            else
              update_config_from_auth_response(response)
            end
          else
            false
          end
        end

        # @param [URI] url A URI object to extract the account from
        # @return [String] The account
        def extract_account_from_url(url)
          url.path.split("/")[2]
        end

        # creates a temporary url
        #
        # @param container [String] Name of container containing object
        # @param object [String] Name of object to get expiring url for
        # @param expires_at [Time] An expiry time for this url
        # @param method [String] The method to use for accessing the object (GET, PUT, HEAD)
        # @param options [Hash] An optional options hash
        # @option options [String] :scheme The scheme to use (http, https)
        # @option options [String] :port A non standard port to use
        #
        # @return [String] url for object
        #
        # @raise [ArgumentError] if +storage_temp_key+ is not set in configuration
        # @raise [ArgumentError] if +method+ is not valid
        #
        # @see http://docs.rackspace.com/files/api/v1/cf-devguide/content/Create_TempURL-d1a444.html
        #
        def create_temp_url(container, object, expires_at, method, options = {})
          raise ArgumentError, "Storage must be instantiated with the :brightbox_temp_url_key option" if @config.storage_temp_key.nil?

          # POST not allowed
          allowed_methods = %w(GET PUT HEAD)
          unless allowed_methods.include?(method)
            raise ArgumentError.new("Invalid method '#{method}' specified. Valid methods are: #{allowed_methods.join(", ")}")
          end

          if management_url.nil?
            message = "Storage must be instantiated with the :brightbox_storage_management_url or you must authenticate first"
            raise Fog::Brightbox::Storage::ManagementUrlUnknown, message
          end

          destination_url = management_url.dup
          object_path = destination_url.path

          destination_url.scheme = options[:scheme] if options[:scheme]
          destination_url.port = options[:port] if options[:port]

          object_path_escaped = "#{object_path}/#{Fog::Storage::Brightbox.escape(container)}/#{Fog::Storage::Brightbox.escape(object, "/")}"
          object_path_unescaped = "#{object_path}/#{Fog::Storage::Brightbox.escape(container)}/#{object}"

          expiry_timestamp = expires_at.to_i
          string_to_sign = [method, expiry_timestamp, object_path_unescaped].join("\n")

          hmac = Fog::HMAC.new("sha1", @config.storage_temp_key)
          sig = sig_to_hex(hmac.sign(string_to_sign))

          destination_url.path = object_path_escaped
          destination_url.query = URI.encode_www_form(:temp_url_sig => sig, :temp_url_expires => expiry_timestamp)
          destination_url.to_s
        end

        private

        def sig_to_hex(str)
          str.unpack("C*").map { |c|
            c.to_s(16)
          }.map { |h|
            h.size == 1 ? "0#{h}" : h
          }.join
        end

        def update_config_from_auth_response(response)
          @config.update_tokens(response.access_token)

          # Only update the management URL if not set
          return true if management_url && account

          unless management_url
            new_management_url = response.management_url
            if new_management_url && new_management_url != management_url.to_s
              @config.storage_management_url = URI.parse(new_management_url)
            end
          end

          unless account
            # Extract the account ID sent by the server
            change_account(extract_account_from_url(@config.storage_management_url))
          end
          true
        end
      end

      # CGI.escape, but without special treatment on spaces
      def self.escape(str, extra_exclude_chars = "")
        str.gsub(/([^a-zA-Z0-9_.-#{extra_exclude_chars}]+)/) do
          "%" + Regexp.last_match[1].unpack("H2" * Regexp.last_match[1].bytesize).join("%").upcase
        end
      end
    end
  end
end
