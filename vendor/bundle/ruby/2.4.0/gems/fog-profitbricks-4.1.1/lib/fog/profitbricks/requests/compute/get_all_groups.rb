module Fog
  module Compute
    class ProfitBricks
      class Real
        # Retrieve a full list of all groups.
        #
        # ==== Parameters
        # * None
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * id<~String>                   - Id of the requested resource
        #     * type<~String>                 - type of the requested resource
        #     * href<~String>                 - url to the requested resource
        #     * items<~Array>
        #       * id<~String>                   - The resource's unique identifier
        #       * type<~String>                 - The type of the requested resource
        #       * href<~String>                 - URL to the object’s representation (absolute path)
        #       * properties<~Hash>             - Hash containing the volume properties.
        #         * name<~String>               - The name of the group.
        #         * createDataCenter<~Boolean>  - The group will be allowed to create virtual data centers.
        #         * createSnapshot<~Boolean>    - The group will be allowed to create snapshots.
        #         * reserveIp<~Boolean>         - The group will be allowed to reserve IP addresses.
        #         * accessActivityLog<~Boolean> - The group will be allowed to access the activity log.
        #       * entities<~Hash>               - A hash containing the group entities.
        #         * users<~Hash>                - A collection of users that belong to this group.
        #           * id<~String>               - The resource's unique identifier.
        #           * type<~String>             - The type of the requested resource.
        #           * href<~String>             - URL to the object’s representation (absolute path).
        #           * items<~Array>             - The array containing individual user resources.
        #         * resources<~Hash>            - A collection of resources that are assigned to this group.
        #           * id<~String>               - The resource's unique identifier.
        #           * type<~String>             - The type of the requested resource.
        #           * href<~String>             - URL to the object’s representation (absolute path).
        #           * items<~Array>             - An array containing individual resources.
        #             * id<~String>               - The resource's unique identifier.
        #             * type<~String>             - The type of the requested resource.
        #             * href<~String>             - URL to the object’s representation (absolute path).
        #
        # {ProfitBricks API Documentation}[https://devops.profitbricks.com/api/cloud/v4/#list-groups]
        def get_all_groups
          request(
            :expects => [200],
            :method  => 'GET',
            :path    => "/um/groups?depth=1"
          )
        end
      end

      class Mock
        def get_all_groups
          response        = Excon::Response.new
          response.status = 200
          response.body   = data[:groups]

          response
        end
      end
    end
  end
end
