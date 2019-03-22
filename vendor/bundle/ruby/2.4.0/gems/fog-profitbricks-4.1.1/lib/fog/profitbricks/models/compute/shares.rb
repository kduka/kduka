require File.expand_path('../share', __FILE__)
require File.expand_path('../../../helpers/compute/data_helper', __FILE__)

module Fog
  module Compute
    class ProfitBricks
      class Shares < Fog::Collection
        include Fog::Helpers::ProfitBricks::DataHelper
        model Fog::Compute::ProfitBricks::Share

        def all(group_id)
          result = service.get_all_shares(group_id)

          load(result.body['items'].each do |share|
            share['group_id'] = group_id
            share['resource_id'] = share['id']
            flatten(share)
          end)
        end

        def get(group_id, resource_id)
          response = service.get_share(group_id, resource_id)
          share = response.body

          share['group_id'] = group_id
          share['resource_id'] = resource_id

          new(flatten(share))
        end
      end
    end
  end
end
