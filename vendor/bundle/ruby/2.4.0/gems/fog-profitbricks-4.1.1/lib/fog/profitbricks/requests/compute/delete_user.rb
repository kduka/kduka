module Fog
  module Compute
    class ProfitBricks
      class Real
        # Blacklists the user, disabling them.
        # The user is not completely purged, therefore if you anticipate needing to create
        # a user with the same name in the future, we suggest renaming the user before you delete it.
        #
        # ==== Parameters
        # * user_id<~String>          - UUID of the user
        #
        # ==== Returns
        # * response<~Excon::Response> - No response parameters
        #   (HTTP/1.1 202 Accepted)
        #
        # {ProfitBricks API Documentation}[https://devops.profitbricks.com/api/cloud/v4/#delete-a-user]
        def delete_user(user_id)
          request(
            :expects => [202],
            :method  => 'DELETE',
            :path    => "/um/users/#{user_id}"
          )
        end
      end

      class Mock
        def delete_user(user_id)
          response = Excon::Response.new
          response.status = 202

          if user = data[:users]['items'].find do |usr|
            usr['id'] == user_id
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
