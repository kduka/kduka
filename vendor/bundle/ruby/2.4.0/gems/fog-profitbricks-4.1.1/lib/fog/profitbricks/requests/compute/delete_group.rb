module Fog
  module Compute
    class ProfitBricks
      class Real
        # Delete a single group.
        # Resources that are assigned to the group are NOT deleted, but are no longer accessible
        # to the group members unless the member is a Contract Owner, Admin, or Resource Owner.
        #
        # ==== Parameters
        # * group_id<~String>          - UUID of the group
        #
        # ==== Returns
        # * response<~Excon::Response> - No response parameters
        #   (HTTP/1.1 202 Accepted)
        #
        # {ProfitBricks API Documentation}[https://devops.profitbricks.com/api/cloud/v4/#delete-a-group]
        def delete_group(group_id)
          request(
            :expects => [202],
            :method  => 'DELETE',
            :path    => "/um/groups/#{group_id}"
          )
        end
      end

      class Mock
        def delete_group(group_id)
          response = Excon::Response.new
          response.status = 202

          if group = data[:groups]['items'].find do |grp|
            grp['id'] == group_id
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
