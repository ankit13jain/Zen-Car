class Car < ApplicationRecord
  validates :license_no, uniqueness: true, length: {in: 7..7}
  validates :license_no, :manufacturer, :model, :hourly_rate, :location, presence: true
  has_many :order, :dependent => :destroy

  STATUS = ["Available", "Reserved", "Checked out"]
  STYLE = ["Coupe", "Sedan", "SUV"]

  def self.handle_not_checked_out_orders()
    #cars_wrong_status = Order.where(:status => "Initiated").where(['(((julianday(?) - julianday("checked_out_at"))*86400) >= 1800)', Time.now])
    cars_wrong_status = Order.where(:status => "Initiated").where(:checked_out_at < (Time.now) + 1800)
    cars_wrong_status.each do |ord|
      ord.update(:status => "Canceled")
      car = Car.where(:id => ord.car_id)
      unless car.nil?
        car.update(:status=>"Available")
      end
    end
  end

  def self.handle_not_returned_orders()
    cars_wrong_status = Order.where(:status => "In Progress").where(['"returned_at" <= ?', Time.now])
    cars_wrong_status.each do |ord|
      ord.update(:status => "Completed")
      car = Car.where(:id => ord.car_id)
      unless car.nil?
        car.update(:status=>"Available")
      end
    end
  end

  def self.validate_cars_db()

    self.handle_not_checked_out_orders()
    self.handle_not_returned_orders()

  end

  def self.search(params)

    self.validate_cars_db()

    where(['manufacturer LIKE ? AND model LIKE ? AND location LIKE ? AND style LIKE ? AND status LIKE ?',
           "%#{params[:manufacturer]}%", "%#{params[:model]}%", "%#{params[:location]}%" , "%#{params[:style]}%",
           "%#{params[:status]}%"])
  end
end
