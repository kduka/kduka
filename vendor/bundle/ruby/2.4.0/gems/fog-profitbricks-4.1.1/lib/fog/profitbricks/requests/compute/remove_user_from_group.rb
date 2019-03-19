module Fog
  module Compute
    class ProfitBricks
      class Real
        # Remove a user from a group.
        #
        # ==== Parameters
        # * group_id<~String> - Required, The ID of the specific group you want to remove a user from.
        # * user_id<~String>  - Required, The ID of the specific user to remove from the group.
        #
        # ==== Returns
        # * response<~Excon::Response> - No response parameters
        #   (HTTP/1.1 202 Accepted)
        #
        # {ProfitBricks API Documentation}[https://devops.profitbricks.com/api/cloud/v4/#remove-user-from-a-group]
        def remove_user_from_group(group_id, user_id)
          request(
            :expects => [202],
            :method   => 'DELETE',
            :path     => "/um/groups/#{group_id}/users/#{user_id}"
          )
        end
      end

      class Mock
        def remove_user_from_group(group_id, user_id)
          response = Excon::Response.new
          response.status = 202

          if group = data[:groups]['items'].find do |grp|
            grp["id"] == group_id
          end
          else
            raise Excon::Error::HTTPStatus, "Resource does not exist"
          end

          if user = data[:users]['items'].find do |usr|
            usr["id"] == user_id
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
