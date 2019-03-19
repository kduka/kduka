module Fog
  module Compute
    class ProfitBricks
      class Real
        # Create a new group and set group privileges.
        #
        # ==== Parameters
        # * options<~Hash>:
        #   * name<~String>               - Required, The name of the group.
        #   * createDataCenter<~Boolean>  - The group will be allowed to create virtual data centers.
        #   * createSnapshot<~Boolean>    - The group will be allowed to create snapshots.
        #   * reserveIp<~Boolean>         - The group will be allowed to reserve IP addresses.
        #   * accessActivityLog<~Boolean> - The group will be allowed to access the activity log.
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * id<~String>                   - The resource's unique identifier.
        #     * type<~String>                 - The type of the created resource.
        #     * href<~String>                 - URL to the object's representation (absolute path).
        #     * properties<~Hash>             - Hash containing the volume properties.
        #       * name<~String>               - The name of the group.
        #       * createDataCenter<~Boolean>  - The group will be allowed to create virtual data centers.
        #       * createSnapshot<~Boolean>    - The group will be allowed to create snapshots.
        #       * reserveIp<~Boolean>         - The group will be allowed to reserve IP addresses.
        #       * accessActivityLog<~Boolean> - The group will be allowed to access the activity log.
        #     * entities<~Hash>               - A hash containing the group entities.
        #       * users<~Hash>                - A collection of users that belong to this group.
        #         * id<~String>               - The resource's unique identifier.
        #         * type<~String>             - The type of the requested resource.
        #         * href<~String>             - URL to the object’s representation (absolute path).
        #         * items<~Array>             - The array containing individual user resources.
        #       * resources<~Hash>            - A collection of resources that are assigned to this group.
        #         * id<~String>               - The resource's unique identifier.
        #         * type<~String>             - The type of the requested resource.
        #         * href<~String>             - URL to the object’s representation (absolute path).
        #         * items<~Array>             - An array containing individual resources.
        #           * id<~String>               - The resource's unique identifier.
        #           * type<~String>             - The type of the requested resource.
        #           * href<~String>             - URL to the object’s representation (absolute path).
        #
        # {ProfitBricks API Documentation}[https://devops.profitbricks.com/api/cloud/v4/#create-a-group]
        def create_group(options = {})
          group = {
            :properties => options
          }

          request(
            :expects => [202],
            :method   => 'POST',
            :path     => "/um/groups",
            :body     => Fog::JSON.encode(group)
          )
        end
      end

      class Mock
        def create_group(options = {})
          if options[:name] == nil
            raise Excon::Error::HTTPStatus, "Attribute 'name' is required"
          end

          response = Excon::Response.new
          response.status = 202

          group_id = Fog::UUID.uuid

          group = {
            'id' => group_id,
            'type'      => 'group',
            'href'      => "https=>//api.profitbricks.com/rest/v4/um/groups/#{group_id}",
            'properties' => {
                'name'              => options[:name],
                'createDataCenter'  => options[:createDataCenter],
                'createSnapshot'    => options[:createSnapshot],
                'reserveIp'         => options[:reserveIp],
                'accessActivityLog' => options[:accessActivityLog]
            },
            'entities' => {
              'users' => {
                'id' => "#{group_id}/owns",
                'type' => 'collection',
                'href' => "https://api.profitbricks.com/cloudapi/v4/um/groups/#{group_id}/users",
                'items' => []
              },
              'resources' => {
                'id' => "#{group_id}/resources",
                'type' => 'collection',
                'href' => "https://api.profitbricks.com/cloudapi/v4/um/groups/#{group_id}/resources",
                'items' => []
              }
            }
          }

          data[:groups]['items'] << group

          response.body = group
          response
        end
      end
    end
  end
end
