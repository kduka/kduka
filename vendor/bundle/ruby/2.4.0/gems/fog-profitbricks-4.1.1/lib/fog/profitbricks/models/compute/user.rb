require File.expand_path('../../../helpers/compute/data_helper', __FILE__)

module Fog
  module Compute
    class ProfitBricks
      class User < Fog::Models::ProfitBricks::Base
        include Fog::Helpers::ProfitBricks::DataHelper

        identity  :id

        attribute :type
        attribute :request_id

        # metadata
        attribute :etag
        attribute :creation_date,   :aliases => 'creationDate'
        attribute :last_login,      :aliases => 'lastLogin'

        # properties
        attribute :firstname
        attribute :lastname
        attribute :email
        attribute :password
        attribute :administrator
        attribute :force_sec_auth,  :aliases => 'forceSecAuth'
        attribute :sec_auth_active, :aliases => 'secAuthActive'

        # entities
        attribute :owns
        attribute :groups

        attr_accessor :options

        def initialize(attributes = {})
          super
        end

        def save
          requires :firstname, :lastname, :email, :password

          options = {}

          options[:firstname]     = firstname
          options[:lastname]      = lastname
          options[:email]         = email
          options[:password]      = password
          options[:administrator] = administrator if administrator
          options[:forceSecAuth]  = force_sec_auth if force_sec_auth

          data = service.create_user(options)
          merge_attributes(flatten(data.body))
          true
        end

        def update
          requires :id, :firstname, :lastname, :email, :administrator, :force_sec_auth

          options = {}
          options[:firstname]     = firstname
          options[:lastname]      = lastname
          options[:email]         = email
          options[:administrator] = administrator
          options[:forceSecAuth]  = force_sec_auth

          data = service.update_user(id, options)
          merge_attributes(flatten(data.body))
          true
        end

        def delete
          requires :id
          service.delete_user(id)
          true
        end
      end
    end
  end
end
