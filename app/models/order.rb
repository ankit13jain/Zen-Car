class Order < ApplicationRecord
  belongs_to :car
  belongs_to :customer

  STATUS = ["Initiated", "In Progress", "Completed"]
  def self.search(params)
    where(['cast(customer_id as text) LIKE ?', "%#{params[:cust_id]}%"])
  end

end
