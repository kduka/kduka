class Ahoy::Event < ApplicationRecord
  include Ahoy::QueryMethods

  self.table_name = "ahoy_events"

  belongs_to :visit
  belongs_to :store, optional: true
  # before_save :finalize


  def finalize
    @store = Store.where(c_subdomain:$request.subdomain,domain:$request.domain,own_domain:true).first

    if @store.nil?
      @subdomain = $request.subdomain[/(\w+)/]
      @store = Store.where(subdomain: @subdomain).first
    end

    self[:store_id] = @store.id
  end
end
