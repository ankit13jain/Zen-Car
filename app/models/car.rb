class Car < ApplicationRecord
  validates :license_no, uniqueness: true, length: {in: 7..7}
  validates :license_no, :manufacturer, :model, :hourly_rate, :location, presence: true

  STATUS = ["Available", "Reserved", "Checked out"]
  STYLE = ["Coupe", "Sedan", "SUV"]
end
