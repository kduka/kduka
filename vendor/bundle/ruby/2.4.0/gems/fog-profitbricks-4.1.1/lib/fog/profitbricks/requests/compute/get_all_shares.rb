module Fog
  module Compute
    class ProfitBricks
      class Real
        # Retrieve a full list of all the resources that are shared through this group
        # and lists the permissions granted to the group members for each shared resource.
        #
        # ==== Parameters
        # * group_id<~String> - Required, The ID of a specific group.
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
        #       * properties<~Hash>           - Hash containing the volume properties.
        #         * editPrivilege<~Boolean>   - The group has permission to edit privileges on this resource.
        #         * sharePrivilege<~Boolean>  - The group has permission to share this resource.
        #
        # {ProfitBricks API Documentation}[https://devops.profitbricks.com/api/cloud/v4/#list-shares]
        def get_all_shares(group_id)
          request(
            :expects => [200],
            :method  => 'GET',
            :path    => "/um/groups/#{group_id}/shares?depth=1"
          )
        end
      end

      class Mock
        def get_all_shares(group_id)
          response        = Excon::Response.new
          response.status = 200
          response.body   = data[:shares]

          response
        end
      end
    end
  end
end
