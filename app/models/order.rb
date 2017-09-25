class Order < ApplicationRecord
  belongs_to :car
  belongs_to :customer

  STATUS = ["Initiated", "In Progress", "Completed"]
  def self.search(params)
    where(['customer_id LIKE ?', "%#{params[:cust_id]}%"])
  end

end
