module Fog
  module Compute
    class ProfitBricks
      class Real
        # Retrieves the attributes of a given LAN
        #
        # ==== Parameters
        # * datacenter_id<~String> - UUID of the datacenter
        # * lan_id<~String>         - UUID of the LAN
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * id<~String> 		  - The resource's unique identifier
        #     * type<~String>		  - The type of the created resource
        #     * href<~String>		  - URL to the object’s representation (absolute path)
        #     * items<~Hash>      - Collection of individual lan objects
        #       * id<~String> 		  - The resource's unique identifier
        #       * type<~String>		  - The type of the created resource
        #       * href<~String>		  - URL to the object’s representation (absolute path)
        #       * metadata<~Hash>	  - Hash containing the LAN metadata
        #         * createdDate<~String>		  - The date the resource was created
        #         * createdBy<~String>		    - The user who created the resource
        #         * etag<~String>				      - The etag for the resource
        #         * lastModifiedDate<~String>	- The last time the resource has been modified
        #         * lastModifiedBy<~String>	  - The user who last modified the resource
        #         * state<~String>            - LAN state
        #       * properties<~Hash> - Hash containing the LAN properties
        #         * name<~String>             - The name of the LAN
        #         * public<~Boolean>          - Boolean indicating if the LAN faces the public Internet or not
        #         * ipFailover<~Array>        - Attributes related to IP failover groups
        #       * entities<~Hash>   - Hash containing the LAN entities
        #         * nics<~Hash> - Hash containing the NIC properties
        #           * id<~String> 		  - The resource's unique identifier
        #           * type<~String>		  - The type of the created resource
        #           * href<~String>		  - URL to the object’s representation (absolute path)
        #           * items<~Hash>      - Collection of individual nic objects
        #             * id<~String> 		  - The resource's unique identifier
        #             * type<~String>		  - The type of the created resource
        #             * href<~String>		  - URL to the object’s representation (absolute path)
        #             * metadata<~Hash>	  - Hash containing the NIC metadata
        #               * createdDate<~String>		  - The date the resource was created
        #               * createdBy<~String>		    - The user who created the resource
        #               * etag<~String>				      - The etag for the resource
        #               * lastModifiedDate<~String>	- The last time the resource has been modified
        #               * lastModifiedBy<~String>	  - The user who last modified the resource
        #               * state<~String>            - NIC state
        #             * properties<~Hash> - Hash containing the NIC properties
        #               * name<~String>             - The name of the NIC
        #               * mac<~String>              - The MAC address of the NIC
        #               * ips<~Array>               - IPs assigned to the NIC represented as a collection
        #               * dhcp<~Boolean>            - Boolean value that indicates if the NIC is using DHCP or not
        #               * lan<~Integer>             - The LAN ID the NIC sits on
        #               * firewallActive<~Boolean>  - Once a firewall rule is added, this will reflect a true value
        #             * entities<~Hash>           - Hash containing the NIC entities
        #               * firewallrules<~Hash>      - A list of firewall rules associated to the NIC represented as a collection
        #                 * id<~String>               - The resource's unique identifier
        #                 * type<~String>			        - The type of the resource
        #                 * href<~String>			        - URL to the object’s representation (absolute path)
        #                 * items<~Array>			        - Collection of individual firewall rules objects
        #                   * id<~String> 		        - The resource's unique identifier
        #                   * type<~String>		        - The type of the resource
        #                   * href<~String>		        - URL to the object’s representation (absolute path)
        #                   * metadata<~Hash>	        - Hash containing the Firewall Rule metadata
        #                     * createdDate<~String>		  - The date the resource was created
        #                     * createdBy<~String>		    - The user who created the resource
        #                     * etag<~String>				      - The etag for the resource
        #                     * lastModifiedDate<~String>	- The last time the resource has been modified
        #                     * lastModifiedBy<~String>	  - The user who last modified the resource
        #                     * state<~String>            - Firewall Rule state
        #                   * properties<~Hash>       - Hash containing the Firewall Rule properties
        #                     * name<~String>             - The name of the Firewall Rule
        #                     * protocol<~String>         - The protocol for the rule: TCP, UDP, ICMP, ANY
        #                     * sourceMac<~Array>         - Only traffic originating from the respective MAC address is allowed.
        #                                                   Valid format: aa:bb:cc:dd:ee:ff. Value null allows all source MAC address
        #                     * sourceIp<~Boolean>        - Only traffic originating from the respective IPv4 address is allowed.
        #                                                   Value null allows all source IPs
        #                     * targetIp<~Integer>        - In case the target NIC has multiple IP addresses, only traffic directed
        #                                                   to the respective IP address of the NIC is allowed. Value null allows all target IPs
        #                     * icmpCode<~Boolean>        - Defines the allowed code (from 0 to 254) if protocol ICMP is chosen.
        #                                                   Value null allows all codes.
        #                     * icmpType<~Boolean>        - Defines the allowed type (from 0 to 254) if the protocol ICMP is chosen.
        #                                                   Value null allows all types
        #                     * portRangeStart<~Boolean>  - Defines the start range of the allowed port (from 1 to 65534)
        #                                                   if protocol TCP or UDP is chosen. Leave portRangeStart and portRangeEnd
        #                                                   value null to allow all ports
        #                     * portRangeEnd<~Boolean>    - Defines the end range of the allowed port (from 1 to 65534)
        #                                                   if the protocol TCP or UDP is chosen. Leave portRangeStart and
        #                                                   portRangeEnd value null to allow all ports
        #
        # {ProfitBricks API Documentation}[https://devops.profitbricks.com/api/cloud/v2/#get-lan]
        def get_lan(datacenter_id, lan_id)
          request(
            :expects => [200],
            :method  => "GET",
            :path    => "/datacenters/#{datacenter_id}/lans/#{lan_id}?depth=5"
          )
        end
      end

      class Mock
        def get_lan(datacenter_id, lan_id)
          if lan = data[:lans]['items'].find do |ln|
            ln["datacenter_id"] == datacenter_id && ln["id"] == lan_id
          end
          else
            raise Excon::Error::HTTPStatus, "Resource does not exist"
          end

          response        = Excon::Response.new
          response.status = 200
          response.body   = lan
          response
        end
      end
    end
  end
end
