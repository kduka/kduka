require File.expand_path('../../../helpers/compute/data_helper', __FILE__)

module Fog
  module Compute
    class ProfitBricks
      class Datacenter < Fog::Models::ProfitBricks::Base
        include Fog::Helpers::ProfitBricks::DataHelper

        identity :id

        attribute :type

        # properties
        attribute :name
        attribute :description
        attribute :location
        attribute :version
        attribute :features

        # metadata
        attribute :created_date, :aliases => 'createdDate', :type => :time
        attribute :created_by, :aliases => 'createdBy'
        attribute :last_modified_date, :aliases => 'lastModifiedDate', :type => :time
        attribute :last_modified_by, :aliases => 'lastModifiedBy'
        attribute :request_id, :aliases => 'requestId'
        attribute :state

        #entities
        attribute :servers
        attribute :volumes
        attribute :loadbalancers
        attribute :lans

        attr_accessor :options

        def initialize(attributes = {})
          super
        end

        def save
          requires :name, :location

          options = {}
          options[:name] = name
          options[:location] = location
          options[:description] = description if description
          options[:servers] = servers if servers
          options[:volumes] = volumes if volumes
          options[:loadbalancers] = loadbalancers if loadbalancers
          options[:lans] = lans if lans

          entities = {}

          # Retrieve servers collection if present and generate appropriate JSON.
          if options.key?(:servers)
            entities[:servers] = collect_entities(options.delete(:servers))
          end

          # Retrieve volumes collection if present and generate appropriate JSON.
          if options.key?(:volumes)
            entities[:volumes] = collect_entities(options.delete(:volumes))
          end

          # Retrieve volumes collection if present and generate appropriate JSON.
          if options.key?(:loadbalancers)
            entities[:loadbalancers] = collect_entities(options.delete(:loadbalancers))
          end

          # Retrieve volumes collection if present and generate appropriate JSON.
          if options.key?(:lans)
            entities[:lans] = collect_entities(options.delete(:lans))
          end

          data = service.create_datacenter(options, entities)
          merge_attributes(flatten(data.body))
          true
        end

        def update
          requires :id

          options = {}
          options[:name] = name if name
          options[:description] = description if description
          data = service.update_datacenter(id, options)
          merge_attributes(flatten(data.body))
          true
        end

        def delete
          requires :id
          data = service.delete_datacenter(id)
          true
        end

        private

        def collect_entities(entities)
          if entities.is_a?(Array) && entities.length > 0
            items = []
            entities.each do |entity|
              if entity.key?(:volumes)
                subentities = collect_entities(entity.delete(:volumes))
                items << {
                  properties: entity,
                  entities: {volumes: subentities}
                }
              else
                items << {properties: entity}
              end
            end
            {items: items}
          end
        end
      end
    end
  end
end
