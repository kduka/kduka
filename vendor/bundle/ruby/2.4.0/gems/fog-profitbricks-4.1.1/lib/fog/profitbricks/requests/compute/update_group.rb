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
        # * group_id<~String>      - Required, The ID of the specific group to update.
        # * options<~Hash>:
        #   * name<~String>               - Required, The name of the group.
        #   * createDataCenter<~Integer>  - The group will be allowed to create virtual data centers.
        #   * createSnapshot<~Integer>    - The group will be allowed to create snapshots.
        #   * reserveIp<~Integer>         - The group will be allowed to reserve IP addresses.
        #   * accessActivityLog<~Integer> - The group will be allowed to access the activity log.
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * id<~String>                   - The resource's unique identifier
        #     * type<~String>                 - The type of the requested resource
        #     * href<~String>                 - URL to the object’s representation (absolute path)
        #     * properties<~Hash>             - Hash containing the volume properties.
        #       * name<~String>               - The name of the group.
        #       * createDataCenter<~Boolean>  - The group will be allowed to create virtual data centers.
        #       * createSnapshot<~Boolean>    - The group will be allowed to create snapshots.
        #       * reserveIp<~Boolean>         - The group will be allowed to reserve IP addresses.
        #       * accessActivityLog<~Boolean> - The group will be allowed to access the activity log.
        #     * entities<~Hash>               - A hash containing the group entities.
        #       * users<~Hash>                - A collection of users that belong to this group.
        #         * id<~String>               - The resource's unique identifier.
        #         * type<~String>             - The type of the requested resource.
        #         * href<~String>             - URL to the object’s representation (absolute path).
        #         * items<~Array>             - The array containing individual user resources.
        #       * resources<~Hash>            - A collection of resources that are assigned to this group.
        #         * id<~String>               - The resource's unique identifier.
        #         * type<~String>             - The type of the requested resource.
        #         * href<~String>             - URL to the object’s representation (absolute path).
        #         * items<~Array>             - An array containing individual resources.
        #           * id<~String>               - The resource's unique identifier.
        #           * type<~String>             - The type of the requested resource.
        #           * href<~String>             - URL to the object’s representation (absolute path).
        #
        # {ProfitBricks API Documentation}[https://devops.profitbricks.com/api/cloud/v4/#update-a-group]
        def update_group(group_id, options = {})
          group = {
              :properties => options
          }

          request(
            :expects => [202],
            :method  => 'PUT',
            :path    => "/um/groups/#{group_id}",
            :body    => Fog::JSON.encode(group)
          )
        end
      end

      class Mock
        def update_group(group_id, options = {})
          if group = data[:groups]['items'].find do |grp|
            grp["id"] == group_id
          end
            group['name']               = options[:name]
            group['createDataCenter']   = options[:createDataCenter] if [true, false].include?(options[:createDataCenter])
            group['createSnapshot']     = options[:createSnapshot] if [true, false].include?(options[:createSnapshot])
            group['reserveIp']          = options[:reserveIp] if [true, false].include?(options[:reserveIp])
            group['accessActivityLog']  = options[:accessActivityLog] if [true, false].include?(options[:accessActivityLog])
          else
            raise Excon::Error::HTTPStatus, "Resource does not exist"
          end

          response        = Excon::Response.new
          response.status = 202
          response.body   = group

          response
        end
      end
    end
  end
end
