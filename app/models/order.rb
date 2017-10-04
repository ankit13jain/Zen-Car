class Order < ApplicationRecord
  belongs_to :car
  belongs_to :customer

  STATUS = ["Initiated", "In Progress", "Completed"]
  def self.search(params)

    # If params contains car id, then consider car id also while displaying results
    p params
    if params.has_key? :car_id
      where(:car_id => params[:car_id])
    else
      where(:customer_id => params[:cust_id])
    end
  end

end
