class Ahoy::Visit < ApplicationRecord
  self.table_name = "ahoy_visits"

  has_many :events, class_name: "Ahoy::Event"
  belongs_to :user, optional: true

#  before_save :finalize


  def finalize
    @store = Store.where(c_subdomain:$request.subdomain, domain:$request.domain,own_domain:true).first


    if @store.nil?
      @subdomain = $request.subdomain[/(\w+)/]
      @store = Store.where(subdomain: @subdomain).first
    end

  self[:store_id] = @store.id

  end


end
