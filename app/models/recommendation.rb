class Recommendation < ApplicationRecord

  validates :manufacturer, :model, presence: true
  STYLE = ["Coupe", "Sedan", "SUV"]
  STATUS = ["Pending", "Approved"]
end
