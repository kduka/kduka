module Fog
  module Compute
    class ProfitBricks
      class Location < Fog::Models::ProfitBricks::Base
        identity  :id

        attribute :name
        attribute :features
        attribute :type
        attribute :image_aliases, :aliases => 'imageAliases'

        attr_accessor :options

        def initialize(attributes = {})
          super
        end
      end
    end
  end
end
