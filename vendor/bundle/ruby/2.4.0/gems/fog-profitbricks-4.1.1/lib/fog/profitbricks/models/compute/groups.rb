require File.expand_path('../group', __FILE__)
require File.expand_path('../../../helpers/compute/data_helper', __FILE__)

module Fog
  module Compute
    class ProfitBricks
      class Groups < Fog::Collection
        include Fog::Helpers::ProfitBricks::DataHelper
        model Fog::Compute::ProfitBricks::Group

        def all()
          result = service.get_all_groups()

          load(result.body['items'].each { |group| flatten(group) })
        end

        def get(group_id)
          response = service.get_group(group_id)
          group = response.body

          new(flatten(group))
        end
      end
    end
  end
end
