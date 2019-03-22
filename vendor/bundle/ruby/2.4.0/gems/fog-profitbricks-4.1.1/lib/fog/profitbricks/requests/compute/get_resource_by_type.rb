module Fog
  module Compute
    class ProfitBricks
      class Real
        # ==== Parameters
        # * resource_type<~String>  - Required, Type of resource. [datacenter, image, snapshot, ipblock]
        # * resource_id<~String>    - Required, The ID of the specific resource to retrieve information about.
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * id<~String>                 - The resource's unique identifier.
        #     * type<~String>               - The type of the requested resource.
        #     * href<~String>               - A URI for accessing the resource object.
        #     * metadata<~Hash>             - Hash containing metadata for the specific resource.
        #       * createdDate<~String>      - A time and date stamp indicating when the resource was created.
        #       * createdBy<~String>        - The user who created the resource.
        #       * etag<~String>             - Resource's ETag.
        #       * lastModifiedDate<~String> - A time and date stamp indicating when the resource was last modified.
        #       * lastModifiedBy<~String>   - The user who last modified the resource.
        #       * state<~String>            - The current state of the resource. [ AVAILABLE, BUSY, INACTIVE ]
        #     * entities<~Hash>             - Hash containing groups the resource is associated with.
        #       * groups<~Hash>             - Hash containing groups associated with the resource.
        #         * id<~String>             - The resource's unique identifier.
        #         * type<~String>           - The type of the created resource.
        #         * href<~String>           - URL to the object's representation (absolute path).
        #         * items<~Array>
        #           * id<~String>           - The resource's unique identifier.
        #           * type<~String>         - The type of the created resource.
        #           * href<~String>         - URL to the object's representation (absolute path).
        #           * properties<~Hash>             - Hash containing the volume properties.
        #             * name<~String>               - The name of the group.
        #             * createDataCenter<~Boolean>  - The group will be allowed to create virtual data centers.
        #             * createSnapshot<~Boolean>    - The group will be allowed to create snapshots.
        #             * reserveIp<~Boolean>         - The group will be allowed to reserve IP addresses.
        #             * accessActivityLog<~Boolean> - The group will be allowed to access the activity log.
        #           * entities<~Hash>               - A hash containing the group entities.
        #             * users<~Hash>                - A collection of users that belong to this group.
        #               * id<~String>               - The resource's unique identifier.
        #               * type<~String>             - The type of the requested resource.
        #               * href<~String>             - URL to the object’s representation (absolute path).
        #               * items<~Array>             - The array containing individual user resources.
        #             * resources<~Hash>            - A collection of resources that are assigned to this group.
        #               * id<~String>               - The resource's unique identifier.
        #               * type<~String>             - The type of the requested resource.
        #               * href<~String>             - URL to the object’s representation (absolute path).
        #               * items<~Array>             - An array containing individual resources.
        #                 * id<~String>               - The resource's unique identifier.
        #                 * type<~String>             - The type of the requested resource.
        #                 * href<~String>             - URL to the object’s representation (absolute path).
        #
        # {ProfitBricks API Documentation}[https://devops.profitbricks.com/api/cloud/v4/#list-a-specific-resource-type]
        def get_resource_by_type(resource_type, resource_id)
          request(
            :expects => [200],
            :method  => 'GET',
            :path    => "/um/resources/#{resource_type}/#{resource_id}?depth=2"
          )
        end
      end

      class Mock
        def get_resource_by_type(resource_type, resource_id)
          if resource = data[:resources]['items'].find do |r|
            r["type"] == resource_type && r["id"] == resource_id
          end
          else
            raise Excon::Error::HTTPStatus, "Resource does not exist"
          end

          response        = Excon::Response.new
          response.status = 200
          response.body   = resource

          response
        end
      end
    end
  end
end
