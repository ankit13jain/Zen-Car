class Car < ApplicationRecord
  validates :license_no, uniqueness: true, length: {in: 7..7}
  validates :license_no, :manufacturer, :model, :hourly_rate, :location, presence: true

  STATUS = ["Available", "Reserved", "Checked out"]
  STYLE = ["Coupe", "Sedan", "SUV"]

  def self.search(search_manu,search_model)
    where(['manufacturer LIKE ? AND model LIKE ?', "%#{search_manu}%", "%#{search_model}%"])
  end
end
