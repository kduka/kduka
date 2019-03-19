module Fog
  module Compute
    class ProfitBricks
      class Real
        # Update a group.
        # Normally a PUT request would require that you pass all the attributes and values.
        # In this implementation, you must supply the name, even if it isn't being changed.
        # As a convenience, the other four attributes will default to false.
        # You should explicitly set them to true if you want to have them enabled.
        #
        # ==== Parameters
        # * group_id<~String>    - Required, The ID of the specific group to update.
        # * resource_id<~String> - Required, The ID of the specific resource to update.
        # * properties<~Hash>:   - A collection of properties.
        #   * editPrivilege<~Boolean>  - The group has permission to edit privileges on this resource.
        #   * sharePrivilege<~Boolean> - The group has permission to share this resource.
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
        # {ProfitBricks API Documentation}[https://devops.profitbricks.com/api/cloud/v4/#update-a-share]
        def update_share(group_id, resource_id, options = {})
          share = {
              :properties => options
          }

          request(
            :expects => [202],
            :method  => 'PUT',
            :path    => "/um/groups/#{group_id}/shares/#{resource_id}",
            :body    => Fog::JSON.encode(share)
          )
        end
      end

      class Mock
        def update_share(group_id, resource_id, options = {})
          if share = data[:shares]['items'].find do |shr|
            shr["id"] == resource_id
          end
            share['editPrivilege']   = options[:editPrivilege] if [true, false].include?(options[:editPrivilege])
            share['sharePrivilege']  = options[:sharePrivilege] if [true, false].include?(options[:sharePrivilege])
          else
            raise Excon::Error::HTTPStatus, "Resource does not exist"
          end

          response        = Excon::Response.new
          response.status = 202
          response.body   = share

          response
        end
      end
    end
  end
end
