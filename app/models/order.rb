class Order < ApplicationRecord
  belongs_to :car
  belongs_to :customer

  STATUS = ["Initiated", "In Progress", "Completed"]
  def self.search(params)

    # If params contains car id, then consider car id also while displaying results
    if params.has_key? :car_id
      where(:car_id => params[:car_id])
    else
      where(:customer_id => params[:cust_id])
    end
  end

  def cancel_unchecked_car
    p "+++++++++++++++++++++++"
    p "+++++++++++++++++++++++"
    p "+++++++++++++++++++++++"
    p "+++++++++++++++++++++++"
    p "+++++++++++++++++++++++"
    p "+++++++++++++++++++++++"
    p "+++++++++++++++++++++++"
    p "+++++++++++++++++++++++"
    p "+++++++++++++++++++++++"
    p "+++++++++++++++++++++++"
    p "+++++++++++++++++++++++"
    p "+++++++++++++++++++++++"
    p "+++++++++++++++++++++++"
    p "+++++++++++++++++++++++"
    p "+++++++++++++++++++++++"
    p "+++++++++++++++++++++++"
    p "+++++++++++++++++++++++"
    p "+++++++++++++++++++++++"
    p "+++++++++++++++++++++++"
    p "+++++++++++++++++++++++"
    Order.find(:id => 4).update(:status => "CANCELED")
  end

end
