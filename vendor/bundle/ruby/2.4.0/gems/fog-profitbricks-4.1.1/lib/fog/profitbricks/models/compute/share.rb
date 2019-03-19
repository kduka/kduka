require File.expand_path('../../../helpers/compute/data_helper', __FILE__)

module Fog
  module Compute
    class ProfitBricks
      class Share < Fog::Models::ProfitBricks::Base
        include Fog::Helpers::ProfitBricks::DataHelper

        identity  :id

        attribute :type

        # properties
        attribute :edit_privilege,   :aliases => 'editPrivilege'
        attribute :share_privilege,  :aliases => 'sharePrivilege'

        attribute :group_id,         :aliases => 'groupId'
        attribute :resource_id,       :aliases => 'resourceId'

        attr_accessor :options

        def initialize(attributes = {})
          super
        end

        def save
          requires :group_id, :resource_id

          options = {}

          options[:editPrivilege]  = edit_privilege if edit_privilege
          options[:sharePrivilege] = share_privilege if share_privilege

          data = service.add_share(group_id, resource_id, options).body
          data['group_id']    = group_id
          data['resource_id'] = resource_id
          merge_attributes(flatten(data))
          true
        end

        def update
          requires :group_id, :resource_id

          options = {}
          options[:editPrivilege]  = edit_privilege if [true, false].include?(edit_privilege)
          options[:sharePrivilege] = share_privilege if [true, false].include?(share_privilege)

          data = service.update_share(group_id, resource_id, options)
          merge_attributes(flatten(data.body))
          true
        end

        def delete
          requires :group_id, :resource_id
          service.delete_share(group_id, resource_id)
          true
        end
      end
    end
  end
end
