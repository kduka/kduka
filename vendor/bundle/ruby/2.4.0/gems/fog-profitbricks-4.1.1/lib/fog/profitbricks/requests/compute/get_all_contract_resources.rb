module Fog
  module Compute
    class ProfitBricks
      class Real
        # Get all contract resources
        #
        # ==== Parameters
        # * None
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * type<~String>                 - The type of the requested resource
        #     * properties<~Hash>
        #       * contractNumber<~Integer>        - The contract number that the returned information is from
        #       * owner<~String>                  - The username of the Contract Owner
        #       * status<~String>                 - The status of the contract. [ BILLABLE...]
        #       * resourceLimits<~Hash>           - An object containing the contract's resource limits
        #         * coresPerServer<~Integer>        - Maximum number of CPU cores per server
        #         * coresPerContract<~Integer>      - Maximum number of CPU cores per contract
        #         * coresProvisioned<~Integer>      - The total number of CPU cores that have been provisioned
        #         * ramPerServer<~Integer>          - The maximum amount of RAM (in MB) that may be provisioned for a particular server under this contract
        #         * ramPerContract<~Integer>        - The maximum amount of RAM (in MB) that may be provisioned under this contract
        #         * ramProvisioned<~Integer>        - The amount of RAM (in MB) that has been provisioned under this contract
        #         * hddLimitPerVolume<~Integer>     - The maximum size (in MB) of an individual hard disk volume
        #         * hddLimitPerContract<~Integer>   - The maximum amount of hard disk space (in MB) that may be provisioned under this contract
        #         * hddVolumeProvisioned<~Integer>  - The amount of hard disk space (in MB) that is currently provisioned
        #         * ssdLimitPerVolume<~Integer>     - The maximum size (in MB) of an individual solid state disk volume
        #         * ssdLimitPerContract<~Integer>   - The maximum amount of solid state disk space (in MB) that may be provisioned under this contract
        #         * ssdVolumeProvisioned<~Integer>  - The amount of solid state disk space (in MB) that is currently provisioned
        #         * reservableIps<~Integer>         - The maximum number of static public IP addresses that may be reserved by this customer across all contracts
        #         * reservedIpsOnContract<~Integer> - The maximum number of static public IP addresses that can be reserved under this contract
        #         * reservedIpsInUse<~Integer>      - The number of static public IP addresses that have been reserved
        #
        # {ProfitBricks API Documentation}[https://devops.profitbricks.com/api/cloud/v4/#contract-resources]
        def get_all_contract_resources
          request(
            :expects => [200],
            :method  => 'GET',
            :path    => "/contracts"
          )
        end
      end

      class Mock
        def get_all_contract_resources
          response        = Excon::Response.new
          response.status = 200
          response.body   = data[:contracts]
          response
        end
      end
    end
  end
end
