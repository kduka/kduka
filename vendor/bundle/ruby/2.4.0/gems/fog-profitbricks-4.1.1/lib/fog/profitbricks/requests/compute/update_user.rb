module Fog
  module Compute
    class ProfitBricks
      class Real
        # Update details about a specific user including their privileges.
        # With this PUT operation, you need to supply values for all the attributes,
        # even if you are only updating some of them.
        #
        # The password attribute is immutable. It is not allowed in update requests.
        # It is recommended that a new user log into the DCD and change their password.
        #
        # ==== Parameters
        # * user_id<~String>      - Required, The ID of the specific user to update.
        # * options<~Hash>:
        #   * firstname<~String>      - Required, The name of the group.
        #   * lastname<~String>       - Required, The group will be allowed to create virtual data centers.
        #   * email<~String>          - Required, The group will be allowed to create snapshots.
        #   * administrator<~Boolean> - Required, The group will be allowed to access the activity log.
        #   * forceSecAuth<~Boolean>  - Required, The group will be allowed to access the activity log.
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * id<~String>               - The resource's unique identifier.
        #     * type<~String>             - The type of the created resource.
        #     * href<~String>             - URL to the object's representation (absolute path).
        #     * metadata<~Hash>           - Hash containing metadata for the user.
        #       * etag<~String>           - ETag of the user.
        #       * creationDate<~String>   - A time and date stamp indicating when the user was created.
        #       * lastLogin<~String>      - A time and date stamp indicating when the user last logged in.
        #     * properties<~Hash>         - Hash containing the user's properties.
        #       * firstname<~String>      - The first name of the user.
        #       * lastname<~String>       - The last name of the user.
        #       * email<~String>          - The e-mail address of the user.
        #       * administrator<~Boolean> - Indicates if the user has administrative rights.
        #       * forceSecAuth<~Boolean>  - Indicates if secure (two-factor) authentication was enabled for the user.
        #       * secAuthActive<~Boolean> - Indicates if secure (two-factor) authentication is enabled for the user.
        #     * entities<~Hash>           - Hash containing resources the user owns, and groups the user is a member of.
        #       * owns<~Hash>             - Hash containing resources the user owns.
        #         * id<~String>               - The resource's unique identifier.
        #         * type<~String>             - The type of the created resource.
        #         * href<~String>             - URL to the object's representation (absolute path).
        #         * items<~Array>
        #           * id<~String>               - The resource's unique identifier.
        #           * type<~String>             - The type of the created resource.
        #           * href<~String>             - URL to the object's representation (absolute path).
        #       * groups<~Hash>           - Hash containing groups the user is a member of.
        #         * id<~String>               - The resource's unique identifier.
        #         * type<~String>             - The type of the created resource.
        #         * href<~String>             - URL to the object's representation (absolute path).
        #         * items<~Array>
        #           * id<~String>               - The resource's unique identifier.
        #           * type<~String>             - The type of the created resource.
        #           * href<~String>             - URL to the object's representation (absolute path).
        #
        # {ProfitBricks API Documentation}[https://devops.profitbricks.com/api/cloud/v4/#update-a-user]
        def update_user(user_id, options = {})
          user = {
              :properties => options
          }

          request(
            :expects => [202],
            :method  => 'PUT',
            :path    => "/um/users/#{user_id}",
            :body    => Fog::JSON.encode(user)
          )
        end
      end

      class Mock
        def update_user(user_id, options = {})
          if user = data[:users]['items'].find do |usr|
            usr["id"] == user_id
          end
            user['firstname']     = options[:firstname]
            user['lastname']      = options[:lastname]
            user['email']         = options[:email]
            user['administrator'] = options[:administrator]
            user['forceSecAuth']  = options[:force_sec_auth] || false
          else
            raise Excon::Error::HTTPStatus, "Resource does not exist"
          end

          response        = Excon::Response.new
          response.status = 202
          response.body   = user

          response
        end
      end
    end
  end
end
