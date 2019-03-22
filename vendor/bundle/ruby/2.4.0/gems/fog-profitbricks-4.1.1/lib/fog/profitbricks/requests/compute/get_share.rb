module Fog
  module Compute
    class ProfitBricks
      class Real
        # Retrieves the attributes of a given volume
        #
        # ==== Parameters
        # * group_id<~String>    - Required, The ID of the specific group to retrieve.
        # * resource_id<~String> - Required, The ID of the specific resource to retrieve.
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * id<~String>                   - Id of the requested resource
        #     * type<~String>                 - type of the requested resource
        #     * href<~String>                 - url to the requested resource
        #     * items<~Array>
        #       * id<~String>                 - The resource's unique identifier
        #       * type<~String>               - The type of the requested resource
        #       * href<~String>               - URL to the object’s representation (absolute path)
        #       * properties<~Hash>           - Hash containing the share properties.
        #         * editPrivilege<~Boolean>   - The group has permission to edit privileges on this resource.
        #         * sharePrivilege<~Boolean>  - The group has permission to share this resource.
        #
        # {ProfitBricks API Documentation}[https://devops.profitbricks.com/api/cloud/v4/#retrieve-a-share]
        def get_share(group_id, resource_id)
          request(
            :expects => [200],
            :method  => "GET",
            :path    => "/um/groups/#{group_id}/shares/#{resource_id}"
          )
        end
      end

      class Mock
        def get_share(group_id, resource_id)
          if share = data[:shares]['items'].find do |shr|
            shr["id"] == resource_id
          end
          else
            raise Excon::Error::HTTPStatus, "Resource does not exist"
          end

          response        = Excon::Response.new
          response.status = 200
          response.body   = share
          response
        end
      end
    end
  end
end
