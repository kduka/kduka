module Fog
  module Compute
    class Brightbox
      class Real
        # This requests the admin password for the database server is reset. The new `admin_password` is only returned in the JSON response to this request.
        #
        # @param [String] identifier Unique reference to identify the resource
        # @param [Hash] options
        # @option options [Boolean] :nested passed through with the API request. When true nested resources are expanded.
        #
        # @return [Hash] if successful Hash version of JSON object
        #
        # @see https://api.gb1.brightbox.com/1.0/#database_server_reset_password_database_server
        #
        def reset_password_database_server(identifier, options = {})
          return nil if identifier.nil? || identifier == ""
          wrapped_request("post", "/1.0/database_servers/#{identifier}/reset_password", [202], options)
        end
      end
    end
  end
end
