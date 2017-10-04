class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

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

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    puts order_params
    @order.car_id = @@car_id
    if(params[:order][:customer_email].nil?)
      @order.customer_id = @@cust_id
    end
    @car = Car.find(@order.car_id)
    @order.reserved_at = Time.now
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
      format.html { render :new }
      format.json { render json: @order.errors, status: :unprocessable_entity }
    end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    params[:order][:total_charges] = ((@order.returned_at - @order.checked_out_at)/3600).to_f * @order.car.hourly_rate
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
    puts "checout", params
    @order = Order.where(:customer_id => params[:id], :status => "Initiated").first
    car = Car.find(@order.car_id)
    respond_to do |format|
      if @order.update(status:"In Progress") && car.update(status:"Checked out")
        format.html { redirect_to root_path, notice: 'Car Checked Out successfully' }
        format.json { render :show, status: :ok, location: @order }
      end
    end
  end

  def return
    @order = Order.where(:customer_id => params[:id], :status => "In Progress").first
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
      #if(!params[:order][:customer_email].nil?)
        cust = Customer.where(:email => params[:order][:customer_email]).first
        puts "params cust email ", params[:order][:customer_email]
        if(!cust.nil?)
          params[:order][:customer_id] = cust.id
          puts "params cust id ", params[:order][:customer_id]
        else
          params[:order][:customer_id] = nil
        end
      #end
      params.require(:order).permit(:checked_out_at, :reserved_at, :returned_at, :car, :status, :total_charges,:customer_id)

    end
end


