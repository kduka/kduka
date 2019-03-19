require File.expand_path('../../../helpers/compute/data_helper', __FILE__)

module Fog
  module Compute
    class ProfitBricks
      class Lan < Fog::Models::ProfitBricks::Base
        include Fog::Helpers::ProfitBricks::DataHelper

        identity  :id
        attribute :type

        # properties
        attribute :name
        attribute :public
        attribute :ip_failover,        :aliases => 'ipFailover'

        # metadata
        attribute :created_date,       :aliases => 'createdDate', :type => :time
        attribute :created_by,         :aliases => 'createdBy'
        attribute :last_modified_date, :aliases => 'lastModifiedDate', :type => :time
        attribute :last_modified_by,   :aliases => 'lastModifiedBy'
        attribute :request_id,         :aliases => 'requestId'
        attribute :state

        # entities
        attribute :nics

        attribute :datacenter_id,      :aliases => 'datacenterId'

        attr_accessor :options

        def save
          requires :datacenter_id

          properties = {}
          properties[:name]   = name if name
          properties[:public] = public if public
          properties[:ipFailover] = ip_failover if ip_failover

          entities = {}
          entities[:nics] = nics if nics

          data = service.create_lan(datacenter_id, properties, entities)
          merge_attributes(flatten(data.body))
          true
        end

        def update
          requires :datacenter_id, :id

          options = {}
          options[:name]   = name if name
          options[:public] = public if public
          options[:ipFailover] = ip_failover if ip_failover

          data = service.update_lan(datacenter_id, id, options)
          merge_attributes(flatten(data.body))
          true
        end

        def delete
          requires :datacenter_id, :id
          service.delete_lan(datacenter_id, id)
          true
        end

        def reload
          requires :datacenter_id, :id

          data = begin
            collection.get(datacenter_id, id)
          rescue Excon::Errors::SocketError
            nil
          end

          return unless data

          new_attributes = data.attributes
          merge_attributes(new_attributes)
          self
        end

        def ready?
          state == 'AVAILABLE'
        end

        def failed?
          state == 'ERROR'
        end
      end
    end
  end
end
