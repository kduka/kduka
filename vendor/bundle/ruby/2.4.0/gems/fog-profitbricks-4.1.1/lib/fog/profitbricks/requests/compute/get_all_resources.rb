module Fog
  module Compute
    class ProfitBricks
      class Real
        # Retrieves a list of all resources and optionally their group associations.
        # Please note that this API call can take a significant amount of time to return when
        # there are a large number of provisioned resources.
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
        #       * metadata<~Hash>               - Hash containing the metadata for the specific resource.
        #         * createdDate<~String>        - A time and date stamp indicating when the resource was created.
        #         * createdBy<~String>          - The user who created the resource.
        #         * etag<~String>               - Resource's ETag.
        #         * lastModifiedDate<~String>   - A time and date stamp indicating when the resource was last modified.
        #         * lastModifiedBy<~String>     - The user who last modified the resource.
        #         * state<~String>              - The current state of the resource. [ AVAILABLE, BUSY, INACTIVE ]
        #       * entities<~Hash>               - A hash containing groups the resource is associated with.
        #         * groups<~Hash>               - A collection of groups associated with the resource.
        #           * id<~String>                   - The resource's unique identifier
        #           * type<~String>                 - The type of the requested resource
        #           * href<~String>                 - URL to the object’s representation (absolute path)
        #           * items<~Array>
        #             * id<~String>                   - The resource's unique identifier
        #             * type<~String>                 - The type of the requested resource
        #             * href<~String>                 - URL to the object’s representation (absolute path)
        #             * properties<~Hash>             - Hash containing the volume properties.
        #               * name<~String>               - The name of the group.
        #               * createDataCenter<~Boolean>  - The group will be allowed to create virtual data centers.
        #               * createSnapshot<~Boolean>    - The group will be allowed to create snapshots.
        #               * reserveIp<~Boolean>         - The group will be allowed to reserve IP addresses.
        #               * accessActivityLog<~Boolean> - The group will be allowed to access the activity log.
        #
        # {ProfitBricks API Documentation}[https://devops.profitbricks.com/api/cloud/v4/#list-resources]
        def get_all_resources
          request(
            :expects => [200],
            :method  => 'GET',
            :path    => "/um/resources?depth=2"
          )
        end
      end

      class Mock
        def get_all_resources
          response        = Excon::Response.new
          response.status = 200
          response.body   = data[:resources]

          response
        end
      end
    end
  end
end
