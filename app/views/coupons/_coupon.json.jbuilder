json.extract! coupon, :id, :code, :number_of_use, :percentage, :expiry, :created_at, :updated_at
json.url coupon_url(coupon, format: :json)
