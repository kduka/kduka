module Fog
  module Compute
    class ProfitBricks
      class Real
        # Adds a specific resource share to a group and optionally allows the setting of permissions
        # for that resource. As an example, you might use this to grant permissions to use an image
        # or snapshot to a specific group.
        #
        # ==== Parameters
        # * options<~Hash>:
        #   * group_id<~String>        - Required, The ID of the specific group to add a resource to.
        #   * resource_id<~String>     - Required, The ID of the specific resource to add.
        #   * editPrivilege<~Boolean>  - The group has permission to edit privileges on this resource.
        #   * sharePrivilege<~Boolean> - The group has permission to share this resource.
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * id<~String>                - The resource's unique identifier.
        #     * type<~String>              - The type of the created resource.
        #     * href<~String>              - URL to the object's representation (absolute path).
        #     * properties<~Hash>          - A collection of properties.
        #       * editPrivilege<~Boolean>  - The group has permission to edit privileges on this resource.
        #       * sharePrivilege<~Boolean> - The group has permission to share this resource.
        #
        # {ProfitBricks API Documentation}[https://devops.profitbricks.com/api/cloud/v4/#add-a-share]
        def add_share(group_id, resource_id, options = {})
          share = {
            :properties => options
          }

          request(
            :expects => [202],
            :method   => 'POST',
            :path     => "/um/groups/#{group_id}/shares/#{resource_id}",
            :body     => Fog::JSON.encode(share)
          )
        end
      end

      class Mock
        def add_share(group_id, resource_id, options = {})
          response = Excon::Response.new
          response.status = 202

          share = {
            'id' => resource_id,
            'type'      => 'resource',
            'href'      => "https=>//api.profitbricks.com/rest/v4/um/groups/#{group_id}/shares/#{resource_id}",
            'properties' => {
                'editPrivilege'  => options[:editPrivilege],
                'sharePrivilege' => options[:sharePrivilege]
            }
          }

          data[:shares]['items'] << share

          response.body = share
          response
        end
      end
    end
  end
end
