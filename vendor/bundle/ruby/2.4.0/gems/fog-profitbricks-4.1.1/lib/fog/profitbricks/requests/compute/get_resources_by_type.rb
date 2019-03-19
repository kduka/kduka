module Fog
  module Compute
    class ProfitBricks
      class Real
        # List all shareable resources of a specific type.
        # Optionally include their association with groups, permissions that a group has
        # for the resource, and users that are members of the group.
        #
        # ==== Parameters
        # * resource_type<~String> - Required, Type of resource. [datacenter, image, snapshot, ipblock]
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * id<~String>                   - "resources"
        #     * type<~String>                 - The type of response, in this case it will be "collection".
        #     * href<~String>                 - A URI for accessing the object. "baseurl/um/resources"
        #     * items<~Array>                 - A collection containing the available resources.
        #       * id<~String>                   - The resource's unique identifier
        #       * type<~String>                 - The type of object.
        #       * href<~String>                 - A URI for accessing the object.
        #
        # {ProfitBricks API Documentation}[https://devops.profitbricks.com/api/cloud/v4/#list-all-resources-of-a-type]
        def get_resources_by_type(resource_type)
          request(
            :expects => [200],
            :method  => 'GET',
            :path    => "/um/resources/#{resource_type}?depth=2"
          )
        end
      end

      class Mock
        def get_resources_by_type(resource_type)
          if resources = data[:resources]['items'].select {|resource| resource['type'] == resource_type}
            result = data[:resources].dup
            result['items'] = resources
          else
            raise Excon::Error::HTTPStatus, "Resource does not exist"
          end

          response = Excon::Response.new
          response.status = 200
          response.body = result
          response
        end
      end
    end
  end
end
