module Fog
  module Compute
    class ProfitBricks
      class Real
        # Create a new user under a particular contract.
        #
        # ==== Parameters
        # * options<~Hash>:
        #   * firstname<~String>      - Required, The name of the group.
        #   * lastname<~String>       - Required, The group will be allowed to create virtual data centers.
        #   * email<~String>          - Required, The group will be allowed to create snapshots.
        #   * password<~String>       - Required, The group will be allowed to reserve IP addresses.
        #   * administrator<~Boolean> - The group will be allowed to access the activity log.
        #   * forceSecAuth<~Boolean>  - The group will be allowed to access the activity log.
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
        #
        # {ProfitBricks API Documentation}[https://devops.profitbricks.com/api/cloud/v4/#create-a-user]
        def create_user(options = {})
          user = {
            :properties => options
          }

          request(
            :expects => [202],
            :method   => 'POST',
            :path     => "/um/users",
            :body     => Fog::JSON.encode(user)
          )
        end
      end

      class Mock
        def create_user(options = {})
          if options[:email] == nil
            raise Excon::Error::HTTPStatus, "Attribute 'email' is required"
          end

          response = Excon::Response.new
          response.status = 202

          user_id = Fog::UUID.uuid

          user = {
            'id' => user_id,
            'type'      => 'user',
            'href'      => "https=>//api.profitbricks.com/rest/v4/um/users/#{user_id}",
            'metadata' => {
                'etag'         => '26a6259cc0c1dae299a5687455dff0ce',
                'creationDate' => '2017-05-22T08:15:55Z',
                'lastLogin'    => '',
            },
            'properties' => {
                'firstname'     => options[:firstname],
                'lastname'      => options[:lastname],
                'email'         => options[:email],
                'password'      => options[:password],
                'administrator' => options[:administrator],
                'forceSecAuth'  => options[:force_sec_auth] || false,
                'secAuthActive'  => options[:sec_auth_active] || false
            },
            'entities' => {
              'owns' => {
                'id' => "#{user_id}/owns",
                'type' => 'collection',
                'href' => "https://api.profitbricks.com/cloudapi/v4/um/users/#{user_id}/owns",
                'items' => []
              },
              'groups' => {
                'id' => "#{user_id}/groups",
                'type' => 'collection',
                'href' => "https://api.profitbricks.com/cloudapi/v4/um/users/#{user_id}/groups",
                'items' => []
              }
            }
          }

          data[:users]['items'] << user

          response.body = user
          response
        end
      end
    end
  end
end
