# README

PLEASE USE GOOGLE CHROME TO TEST

## Preconfigured credentials:

```
*** Superadmin ***
username: superadmin@abc.com
password: password

*** Admin ***
username: admin@admin.com
password: password
```
PLEASE DON'T CHANGE THESE CREDENTIALS. If you want to test update password functionality, please unsure you change the passwords back to these preconfigured password. This will enable other peers as well to review our work.

### Signup
1. Click on 'sign up' on the homepage
2. Enter details, and click 'sign up'

### Edit
1. Click on 'Edit profile' on the nav bar, top right
2. Enter details, and click 'update'
3. Current password is asked while updating details, for security purpose

### Delete
1. Click on 'Edit profile' on the nav bar, top right
2. Click 'Cancel my account'
3. Confirm delete action by clicking 'Yes' on the popup

### Search
1. On the homepage, you will see a search bar. To view list of all cars, perform an empty search i.e. just click search without any filers

*Screenshot*
![search](https://media.github.ncsu.edu/user/8222/files/584c7b22-a958-11e7-9689-94077fb8ce88)

### Reserve a car
1. Search for the car from search bar. The result will contain all attributes of the car.
2. You can book any car, by clicking on "Reserve" button
3. Note that a car may be reserved for a particular time, which is why it's status is "Reserved". But you can still book it for other time period. You can check for what time period car is available, by clicking on "Check Availability" button
4. You can "Reserve" a car for a minimum of 1 hour, and maximum of 10 hours. Also, you cannot book a car more than 7 days in advance. These validation are being done.
5. You cannot have more than 1 reservation at a time.

*Screenshot*

![reserve](https://media.github.ncsu.edu/user/8222/files/ab47edc0-a958-11e7-8dc5-c97ed5542b7e)

### Checkout and Return button
1. Once you reserve a car, on your homepage you will see a "checkout" button. Similarly, once you check out the car, on the same place you will see an option to "return" the car
2. Note that since reservation should be minimum 1 hour, if you return before 1 hour you will be charged for one hour.
3. After successfully returning the car, you will see your total fee for previous successful rental displayed on the homepage

### Checkout History
1. On the homepage, you can check this by clicking "Order History"  

*Screenshot*

![checkout](https://media.github.ncsu.edu/user/8222/files/6bf9bc3c-a95a-11e7-9c2d-dee6307ffff6)

## Admin

### Login and edit profile
1. There's no separate login page, use the homepage form and above mentioned credentials.
2. To edit, click on 'Edit profile' on the nav bar, top right
3. Enter details, and click 'update'
4. Current password is asked while updating details, for security purpose

### Manage admins
1. On the homepage, you will see "ADMINS" heading, that contains a list of all admins.
2. You can create a new admin by clicking on"New Admin" button, and selecting the check box for admin flag.
2. You can view and edit any admin. Also, you can delete other admins (except yourself)

### Manage superadmins
1. On the homepage, you will see "SUPERADMINS" heading, that contains a list of all superadmins.
2. You can only view superadmins, neither edit nor delete them.

### Manage cars
1. On the homepage, you will see "CARS" heading, that contains a list of all cars.
2. You can add a new car by clicking on "New Car" button, and entering appropriate details. Validations have ben done for this form, such as license plate number should be a 7-digit unique string.
3. To view attributes of a car, click on "Show". You can also view the checkout history of a car by clicking on the "Show car history" button, that also displays user email for a particular reservation.
4. To edit attributes of a car, click on "Edit" button on the homepage.
5. To delete a car, click "Destroy". Note that you cannot delete resrerved or checked out car. Also, deleting any existing car will remove all its entries from reservation history.
6. To change status of a car, you can reserve on behalf of the customer by searching for the car via search bar, and then clicking "Reserve". You will need to enter exact email id of the customer to book on his behalf.

### Manage Customers
1. On the homepage, you will see "CUSTOMERS" heading, that contains a list of all customers.
2. You can view all customer attributes, except password, by clicking on "Show"
3. To view checkout history of customer, click on "Show" then "Order history"
4. To delete, click on "Destroy". Note that you cannot delete a customer with an active reservation. Also, deleting any existing customer will remove all its entries from reservation history.

### Manage Reservations
1. On the homepage, you will see "RESERVATIONS" heading, that contains a list of all reservation.
2. To checkout or return on behalf of the customer, you first need to check which customer does the reservation belong to. Then go his profile and you will see a "Check out" or "Return" button.
3. You can edit or delete any reservation from this list.

## System features
1. The system will cancel a reservation if customer doesn't check out a car in time with 30 minutes elasticity. The corresponding car can then be booked for that time slot.
2. The system will return a car on behalf of customer, if he doesn't return on the specified time.

## Unit Test
1. Thoroughly tested car model and car controller. Unit test module for the same can be found here <br />```test/unit/car_test.rb```

## BONUS FEATURES IMPLEMENTED
1. You can suggest a new car to be added to the system, by clicking on the "Provide car recommendation" button on the homepage. This will trigger a request sent to the admin, who can either approve or deny the request. Admin can also change the attributes of the recommended car.

# To get the application up and running

Things you may want to cover:

* Ruby version - 2.4.1p111

* Rails version - 5.1.4

* System dependencies - run 'bundle install' to install all the dependencies

* Configuration

* Database creation - using Postgre sql

* Database initialization - an admin has to be created using rails console on the server

* How to run the test suite - Run the following commands
```
                            rails db:test:prepare
                            rails test test/unit/car_test.rb
```                            

* Services (job queues, cache servers, search engines, etc.) - It uses rails cron jobs to change the status of Reserved Car to Available when not checked out without half an hour of the said 'check out time'

* Deployment instructions - Code is deployed to Heroku server from the Master branch of GIT
