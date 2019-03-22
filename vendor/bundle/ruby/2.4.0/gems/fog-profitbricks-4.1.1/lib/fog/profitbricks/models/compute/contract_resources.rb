require File.expand_path('../contract_resource', __FILE__)
require File.expand_path('../../../helpers/compute/data_helper', __FILE__)

module Fog
  module Compute
    class ProfitBricks
      class ContractResources < Fog::Collection
        include Fog::Helpers::ProfitBricks::DataHelper
        model Fog::Compute::ProfitBricks::ContractResource

        def all
          result = service.get_all_contract_resources

          load([flatten(result.body)])
        end
      end
    end
  end
end
