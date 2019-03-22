module Fog
  module Compute
    class ProfitBricks
      class Real
        # Add an existing user to a group.
        #
        # ==== Parameters
        # * group_id<~String> - Required, The ID of the specific group you want to add a user to.
        # * user_id<~String>  - Required, The ID of the specific user to add to the group.
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
        # {ProfitBricks API Documentation}[https://devops.profitbricks.com/api/cloud/v4/#add-user-to-group]
        def add_user_to_group(group_id, user_id)
          usr = {
            :id => user_id
          }

          request(
            :expects => [202],
            :method   => 'POST',
            :path     => "/um/groups/#{group_id}/users",
            :body     => Fog::JSON.encode(usr)
          )
        end
      end

      class Mock
        def add_user_to_group(group_id, user_id)
          response = Excon::Response.new
          response.status = 202

          if group = data[:groups]['items'].find do |grp|
            grp["id"] == group_id
          end
          else
            raise Excon::Error::HTTPStatus, "Resource does not exist"
          end

          if user = data[:users]['items'].find do |usr|
            usr["id"] == user_id
          end
          else
            raise Excon::Error::HTTPStatus, "Resource does not exist"
          end

          group['users']['items'] << user
          user['groups']['items'] << group

          response.body = user
          response
        end
      end
    end
  end
end
