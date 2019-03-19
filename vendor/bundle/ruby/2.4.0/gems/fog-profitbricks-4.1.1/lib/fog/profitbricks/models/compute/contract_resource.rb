require File.expand_path('../../../helpers/compute/data_helper', __FILE__)

module Fog
  module Compute
    class ProfitBricks
      class ContractResource < Fog::Models::ProfitBricks::Base
        include Fog::Helpers::ProfitBricks::DataHelper

        # properties
        attribute :contract_number,             :aliases => 'contractNumber'
        attribute :owner
        attribute :status
        attribute :cores_per_server,            :aliases => 'coresPerServer'
        attribute :cores_per_contract,          :aliases => 'coresPerContract'
        attribute :cores_provisioned,           :aliases => 'coresProvisioned'
        attribute :ram_per_server,              :aliases => 'ramPerServer'
        attribute :ram_per_contract,            :aliases => 'ramPerContract'
        attribute :ram_provisioned,             :aliases => 'ramProvisioned'
        attribute :hdd_limit_per_volume,        :aliases => 'hddLimitPerVolume'
        attribute :hdd_limit_per_contract,      :aliases => 'hddLimitPerContract'
        attribute :hdd_volume_provisioned,      :aliases => 'hddVolumeProvisioned'
        attribute :ssd_limit_per_volume,        :aliases => 'ssdLimitPerVolume'
        attribute :ssd_limit_per_contract,      :aliases => 'ssdLimitPerContract'
        attribute :ssd_volume_provisioned,      :aliases => 'ssdVolumeProvisioned'
        attribute :reservable_ips,              :aliases => 'reservableIps'
        attribute :reservable_ips_on_contract,  :aliases => 'reservedIpsOnContract'
        attribute :reservable_ips_in_use,       :aliases => 'reservedIpsInUse'

        def initialize(attributes = {})
          super
        end
      end
    end
  end
end
