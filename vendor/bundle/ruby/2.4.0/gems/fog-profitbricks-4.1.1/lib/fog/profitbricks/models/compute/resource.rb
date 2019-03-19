require File.expand_path('../../../helpers/compute/data_helper', __FILE__)

module Fog
  module Compute
    class ProfitBricks
      class Resource < Fog::Models::ProfitBricks::Base
        include Fog::Helpers::ProfitBricks::DataHelper

        identity  :id
        attribute :type

        # metadata
        attribute :created_date,       :aliases => 'createdDate'
        attribute :created_by,         :aliases => 'createdBy'
        attribute :etag
        attribute :last_modified_date, :aliases => 'lastModifiedDate'
        attribute :last_modified_by,   :aliases => 'lastModifiedBy'
        attribute :state

        # entities
        attribute :groups

        attr_accessor :options

        def initialize(attributes = {})
          super
        end
      end
    end
  end
end
