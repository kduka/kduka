module Fog
  module Compute
    class ProfitBricks
      class Real
        # Retrieve details about a specific user including what groups and resources the user is associated with.
        #
        # ==== Parameters
        # * user_id<~String>      - Required, UUID of the user
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * id<~String>               - The resource's unique identifier.
        #     * type<~String>             - The type of the resource.
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
        # {ProfitBricks API Documentation}[https://devops.profitbricks.com/api/cloud/v4/#retrieve-a-user]
        def get_user(user_id)
          request(
            :expects => [200],
            :method  => "GET",
            :path    => "/um/users/#{user_id}?depth=1"
          )
        end
      end

      class Mock
        def get_user(user_id)
          if user = data[:users]['items'].find do |usr|
            usr["id"] == user_id
          end
          else
            raise Excon::Error::HTTPStatus, "Resource does not exist"
          end

          response        = Excon::Response.new
          response.status = 200
          response.body   = user
          response
        end
      end
    end
  end
end
