require File.expand_path('../user', __FILE__)
require File.expand_path('../../../helpers/compute/data_helper', __FILE__)

module Fog
  module Compute
    class ProfitBricks
      class Users < Fog::Collection
        include Fog::Helpers::ProfitBricks::DataHelper
        model Fog::Compute::ProfitBricks::User

        def all
          response = service.get_all_users

          load(response.body['items'].each { |user| flatten(user) })
        end

        def get(user_id)
          response = service.get_user(user_id)
          share = response.body

          new(flatten(share))
        end

        def list_group_users(group_id)
          response = service.get_group_users(group_id)

          load(response.body['items'].each { |user| flatten(user) })
        end

        def add_group_user(group_id, user_id)
          response = service.add_user_to_group(group_id, user_id)
          user = response.body

          new(flatten(user))
        end

        def remove_group_user(group_id, user_id)
          service.remove_user_from_group(group_id, user_id)

          true
        end
      end
    end
  end
end
