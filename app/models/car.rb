class Car < ApplicationRecord
  validates :license_no, uniqueness: true, length: {in: 7..7}
  validates :license_no, :manufacturer, :model, :hourly_rate, :location, presence: true
  has_many :order, :dependent => :destroy

  STATUS = ["Available", "Reserved", "Checked out"]
  STYLE = ["Coupe", "Sedan", "SUV"]

  def self.search(params)
    where(['manufacturer LIKE ? AND model LIKE ? AND location LIKE ? AND style LIKE ? AND status LIKE ?',
           "%#{params[:manufacturer]}%", "%#{params[:model]}%", "%#{params[:location]}%" , "%#{params[:style]}%",
           "%#{params[:status]}%"])
  end
end
