json.extract! order, :id, :checked_out_at, :reserved_at, :returned_at, :car_id, :customer_id, :status, :total_charges, :created_at, :updated_at
json.url order_url(order, format: :json)
