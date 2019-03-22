require File.expand_path('../resource', __FILE__)
require File.expand_path('../../../helpers/compute/data_helper', __FILE__)

module Fog
  module Compute
    class ProfitBricks
      class Resources < Fog::Collection
        include Fog::Helpers::ProfitBricks::DataHelper
        model Fog::Compute::ProfitBricks::Resource

        def all
          response = service.get_all_resources

          load(response.body['items'].each { |resource| flatten(resource) })
        end

        def get_resource_by_type(resource_type, resource_id)
          response = service.get_resource_by_type(resource_type, resource_id)
          share = response.body

          new(flatten(share))
        end

        def get_by_type(resource_type)
          response = service.get_resources_by_type(resource_type)

          load(response.body['items'].each { |resource| flatten(resource) })
        end
      end
    end
  end
end
