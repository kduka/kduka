module Fog
  module Compute
    class ProfitBricks
      class Real
        # Remove a resource share from a specified group.
        #
        # ==== Parameters
        # * group_id<~String>    - Required, The ID of the specific group containing the resource to delete.
        # * resource_id<~String> - Required, The ID of the specific resource to delete.
        #
        # ==== Returns
        # * response<~Excon::Response> - No response parameters
        #   (HTTP/1.1 202 Accepted)
        #
        # {ProfitBricks API Documentation}[https://devops.profitbricks.com/api/cloud/v4/#delete-a-share]
        def delete_share(group_id, resource_id)
          request(
            :expects => [202],
            :method  => 'DELETE',
            :path    => "/um/groups/#{group_id}/shares/#{resource_id}"
          )
        end
      end

      class Mock
        def delete_share(group_id, resource_id)
          response = Excon::Response.new
          response.status = 202

          if share = data[:shares]['items'].find do |shr|
            shr['id'] == resource_id
          end
          else
            raise Excon::Error::HTTPStatus, "Resource does not exist"
          end

          response
        end
      end
    end
  end
end
