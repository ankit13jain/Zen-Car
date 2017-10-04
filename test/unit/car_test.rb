require 'test_helper'

class CarTest < ActiveSupport::TestCase

  test "car should have manufacturer, model, rates, location" do
    car = Car.new
    car.manufacturer = 'BMW'
    assert_not car.save
  end

  test "car license number should be 7 characters" do
    car = Car.new
    car.license_no = 'ABCDESGD'
    assert_no_match /^[a-zA-Z0-9]{7}$/, car.license_no, 'license no should be 7 characters with no special charac'
  end

  test "car search with zero or more parameter" do
    car = Car.new
    car.manufacturer = 'BMW'
    car.license_no =  'MyString'
    car.hourly_rate = '1.5'
    car.model = 'MyString'
    car.location = 'MyString'
    assert Car.search({})
  end

  test "car can be deleted only if available" do
    car = Car.new
    car.id = '1'
    car.manufacturer = 'BMW'
    car.license_no =  'MyString'
    car.hourly_rate = '1.5'
    car.model = 'MyString'
    car.location = 'MyString'
    car.status = 'Available'
    car.created_at = '2017-10-03 20:39:44.145521'
    car.updated_at = '2017-10-03 20:39:44.145521'
    car.style = 'SUV'
    assert car.destroy
  end


end