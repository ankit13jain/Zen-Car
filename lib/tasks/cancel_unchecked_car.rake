namespace :cancel_unchecked_cars do
  desc "Rake task to cancel unchecked tasks, and make cars available after reservation period"
  task :check => :environment do

    @orders = Order.where(:status => ["Initiated"])

    @orders.each do |ord|
      if Time.now - ord.checked_out_at >= 1800
        ord.update(:status => "Canceled")
        @car = Car.find(ord.car_id)
        @car.update(:status => "Available")
      end
    end

  end

end


namespace :automatically_return_reserved_cars do
  desc "Rake task to make car available after return period has passed"
  task :check => :environment do

    @orders = Order.where(:status => ["In Progress"])

    @orders.each do |ord|
      if Time.now >= ord.reserved_at
        ord.update(:status => "Completed")
        @car = Car.find(ord.car_id)
        @car.update(:status => "Available")
      end
    end

  end

end