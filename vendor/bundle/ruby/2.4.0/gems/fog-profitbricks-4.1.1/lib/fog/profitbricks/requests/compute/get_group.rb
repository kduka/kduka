module Fog
  module Compute
    class ProfitBricks
      class Real
        # Retrieves the attributes of a given volume
        #
        # ==== Parameters
        # * group_id<~String>      - Required, UUID of the group
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * id<~String>                   - The resource's unique identifier
        #     * type<~String>                 - The type of the requested resource
        #     * href<~String>                 - URL to the object’s representation (absolute path)
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
        # {ProfitBricks API Documentation}[https://devops.profitbricks.com/api/cloud/v4/#retrieve-a-group]
        def get_group(group_id)
          request(
            :expects => [200],
            :method  => "GET",
            :path    => "/um/groups/#{group_id}"
          )
        end
      end

      class Mock
        def get_group(group_id)
          if group = data[:groups]['items'].find do |grp|
            grp["id"] == group_id
          end
          else
            raise Excon::Error::HTTPStatus, "Resource does not exist"
          end

          response        = Excon::Response.new
          response.status = 200
          response.body   = group
          response
        end
      end
    end
  end
end
