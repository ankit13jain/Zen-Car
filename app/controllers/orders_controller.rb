class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authorize_admin, only: [:index]
  before_action :check_prior_reservation, only: [:new, :create]

  def check_prior_reservation
    # Customer should not be able to reserve more than 1 car at a time

    @prior_reservation = Order.where(:customer_id => current_customer.id, :status => ["Initiated", "In Progress"])
    unless @prior_reservation.blank?
      flash[:notice] = "ERROR: Cannot reserve more than one car"
      redirect_to root_path and return
    end
  end

  def authorize_admin
    redirect_to root_path, alert: 'Admins only!' unless current_customer and current_customer.admin?
  end

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @@cust_id = params[:cust_id]
    @order.car = Car.find(params[:car_id])
    @@car_status = @order.car.status
    @@car_id = @order.car.id
  end

  # GET /orders/1/edit
  def edit
  end

  def is_valid_date_range date1, date2
    if (date1 - date2).between?(3600.0, 36000.0)
      true
    else
      false
    end
  end

  # POST /orders
  # POST /orders.json
  def create

    @order = Order.new(order_params)
    puts order_params
    @order.car_id = @@car_id
    @order.customer_id = @@cust_id
    @car = Car.find(@order.car_id)
    @order.reserved_at = Time.now

    # Validate date
    unless is_valid_date_range @order.returned_at, @order.checked_out_at
      flash[:notice] = "ERROR: Can reserve only between 1 to 10 hours. Please try again."
      redirect_to root_path and return
    end

    @order.status = "Initiated"
    @order.total_charges = ((@order.returned_at - @order.checked_out_at)/3600).to_f * @order.car.hourly_rate
    respond_to do |format|
    #if @@car_status == "Available" && @order.save
    if @order.save
      @car.status = "Reserved"
      @car.save
      format.html { redirect_to @order, notice: 'Order was successfully created.' }
      format.json { render :show, status: :created, location: @order }
    else
      flash[:notice] = "There was an error creating an order"
      format.html { render :root_path }
      format.json { render json: @order.errors, status: :unprocessable_entity }
    end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def checkout
    @order = Order.where(:customer_id => current_customer.id, :status => "Initiated").first
    car = Car.find(@order.car_id)
    respond_to do |format|
      if @order.update(status:"In Progress") && car.update(status:"Checked out")
        format.html { redirect_to root_path, notice: 'Car Checked Out successfully' }
        format.json { render :show, status: :ok, location: @order }
      end
    end
  end

  def return
    @order = Order.where(:customer_id => current_customer.id, :status => "In Progress").first
    car = Car.find(@order.car_id)
    respond_to do |format|
      if @order.update(status:"Completed") && car.update(status:"Available")
        format.html { redirect_to root_path, notice: 'Car Returned successfully' }
        format.json { render :show, status: :ok, location: @order }
      end
    end
  end

  def history
    @orders = Order.search(params)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:checked_out_at, :reserved_at, :returned_at, :car, :customer_id, :status, :total_charges)
    end
end


