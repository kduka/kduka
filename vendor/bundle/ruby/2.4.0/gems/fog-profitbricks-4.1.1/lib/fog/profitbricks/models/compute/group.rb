require File.expand_path('../../../helpers/compute/data_helper', __FILE__)

module Fog
  module Compute
    class ProfitBricks
      class Group < Fog::Models::ProfitBricks::Base
        include Fog::Helpers::ProfitBricks::DataHelper

        identity  :id

        attribute :type
        attribute :request_id

        # properties
        attribute :name
        attribute :create_datacenter,       :aliases => 'createDataCenter'
        attribute :create_snapshot,         :aliases => 'createSnapshot'
        attribute :reserve_ip,              :aliases => 'reserveIp'
        attribute :access_activity_log,     :aliases => 'accessActivityLog'

        # entities
        attribute :users
        attribute :resources

        attr_accessor :options

        def initialize(attributes = {})
          super
        end

        def save
          requires :name

          options = {}
          options[:name]              = name
          options[:createDataCenter]  = create_datacenter if create_datacenter
          options[:createSnapshot]    = create_snapshot if create_snapshot
          options[:reserveIp]         = reserve_ip if reserve_ip
          options[:accessActivityLog] = access_activity_log if access_activity_log

          data = service.create_group(options)
          merge_attributes(flatten(data.body))
          true
        end

        def update
          requires :id, :name

          options = {}
          options[:name]              = name
          options[:createDataCenter]  = create_datacenter if [true, false].include?(create_datacenter)
          options[:createSnapshot]    = create_snapshot if [true, false].include?(create_snapshot)
          options[:reserveIp]         = reserve_ip if [true, false].include?(reserve_ip)
          options[:accessActivityLog] = access_activity_log if [true, false].include?(access_activity_log)

          data = service.update_group(id, options)
          merge_attributes(flatten(data.body))
          true
        end

        def delete
          requires :id
          service.delete_group(id)
          true
        end
      end
    end
  end
end
