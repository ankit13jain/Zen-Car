class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  #before_action :set_customer_car, only: [:show, :index]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    cust_ids = []
    car_ids = []
    @orders.each do |order|
      cust_ids << order.customer_id
      car_ids << order.car_id
    end
    cars = Car.where(:id => car_ids)
    customers = Customer.where(:id => cust_ids)
    car_hash = {}
    cust_hash = {}
    cars.each do |car|
      car_hash[car.id] = car
    end
    customers.each do |cust|
      cust_hash[cust.id] = cust
    end
    @orders.each do |order|
      order.car = car_hash[order.car_id]
      order.customer = cust_hash[order.customer_id]
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order.car = Car.find(@order.car_id)
    @order.customer = Customer.find(@order.customer_id)
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

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    puts order_params
    @order.car_id = @@car_id
    @order.customer_id = @@cust_id
    @car = Car.find(@order.car_id)
    @order.reserved_at = Time.now
    @order.total_charges = ((@order.returned_at - @order.checked_out_at)/3600).to_f * @order.car.hourly_rate
    respond_to do |format|
    if @@car_status == "Available" && @order.save
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
