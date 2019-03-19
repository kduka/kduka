module Fog
  module Compute
    class ProfitBricks
      class Real
        # Create a new virtual data center
        #
        # ==== Parameters
        # * options<~Hash>:
        #     * name<~String>         - The name of the data center
        #     * region<~String>       - The physical location where the data center will be created ("de/fkb", "de/fra", or "us/las")
        #     * description<~String>  - An optional description for the data center, e.g. staging, production.
        #     * servers<~Hash>        - A collection of servers
        #     * volumes<~Hash>        - A collection of volumes
        #     * loadbalancers<~Hash>  - A collection of loadbalancers
        #     * lans<~Hash>           - A collection of LANs in a data center
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * id<~String>                   - The resource's unique identifier
        #     * type<~String>                 - The type of the requested resource
        #     * href<~String>                 - URL to the object’s representation (absolute path)
        #     * metadata<~Hash>               - A hash containing the resource's metadata
        #       * createdDate<~String>        - The date the resource was created
        #       * createdBy<~String>          - The user who created the resource
        #       * etag<~String>               - The etag for the resource
        #       * lastModifiedDate<~String>   - The last time the resource has been modified
        #       * lastModifiedBy<~String>     - The user who last modified the resource
        #       * state<~String>              - Data center state (AVAILABLE, BUSY, INACTIVE)
        #     * properties<~Hash>             - A hash containing the resource's properties
        #       * name<~String>               - The name of the data center
        #       * description<~String>        - The description of the data center
        #       * location<~String>           - The location where the data center was provisioned ("de/fkb", "de/fra", or "us/las")
        #       * version<~Integer>           - The version of the data center
        #       * features<~Array>            - The features of the data center
        #     * entities<~Hash>               - A hash containing the datacenter entities
        #       * servers<~Hash>              - A collection that represents the servers in a data center
        #       * volumes<~Hash>              - A collection that represents volumes in a data center
        #       * loadbalancers<~Hash>        - A collection that represents the loadbalancers in a data center
        #       * lans<~Hash>                 - A collection that represents the LANs in a data center
        #
        # {ProfitBricks API Documentation}[https://devops.profitbricks.com/api/cloud/v2/#create-a-data-center]
        def create_datacenter(options, entities={})
          datacenter = {
            :properties => options,
            :entities => entities
          }

          request(
            :expects => [202],
            :method => 'POST',
            :path => '/datacenters',
            :body => Fog::JSON.encode(datacenter)
          )
        end
      end

      class Mock
        def create_datacenter(options, entities={})
          dc = {
            :properties => options,
            :entities => entities
          }

          if dc[:properties][:location] == nil
            raise Excon::Error::HTTPStatus, "Attribute 'location' is required"
          end

          dc_3_id = Fog::UUID.uuid
          dc_4_id = Fog::UUID.uuid
          datacenter = {
            'id' => dc_3_id,
            'type' => 'datacenter',
            'properties' => {
              'name' => dc[:properties][:name],
              'description' => dc[:properties][:description],
              'location' => dc[:properties][:location],
              'version' => 1
            }
          }

          if entities != nil and entities != {}
            datacenter = {
              'id' => dc_4_id,
              'type' => 'datacenter',
              'properties' => {
                'name' => dc[:properties][:name],
                'description' => dc[:properties][:description],
                'location' => dc[:properties][:location],
                'version' => 1
              },
              'entities' => {
                'volumes' => {
                  'items' =>
                    [
                      {
                        'type' => 'volume',
                        'properties' => {
                          'name' => dc[:entities][:volumes][:items][0][:properties][:name],
                          'type' => dc[:entities][:volumes][:items][0][:properties][:type],
                          'size' => dc[:entities][:volumes][:items][0][:properties][:size],
                          'bus' => dc[:entities][:volumes][:items][0][:properties][:bus],
                          'licenceType' => dc[:entities][:volumes][:items][0][:properties][:licenceType],
                          'availabilityZone' => dc[:entities][:volumes][:items][0][:properties][:availabilityZone]
                        }
                      }
                    ]
                },
                'servers' => {
                  'items' =>
                    [
                      {
                        'properties' => {
                          'name' => dc[:entities][:servers][:items][0][:properties][:name],
                          'cores' => dc[:entities][:servers][:items][0][:properties][:cores],
                          'ram' => dc[:entities][:servers][:items][0][:properties][:ram]
                        }
                      }
                    ]
                }
              }
            }
          end

          data[:datacenters]['items'] << datacenter
          response = Excon::Response.new
          response.status = 202
          response.body = datacenter
          response
        end
      end
    end
  end
end
