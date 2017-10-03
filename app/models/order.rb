class Order < ApplicationRecord
  belongs_to :car
  belongs_to :customer

  STATUS = ["Initiated", "In Progress", "Completed", "Canceled"]
  def self.search(params)
    where(['cast(customer_id as text) LIKE ?', "%#{params[:cust_id]}%"])
  end

end
