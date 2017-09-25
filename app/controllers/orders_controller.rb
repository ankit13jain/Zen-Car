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
    #@order.car_id = params[:car_id]
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
    respond_to do |format|
        puts "$$$$$$$$"
        puts @@car_status
        puts "##########"
        puts @@cust_id
        puts "#$%^&*("
        puts @order.reserved_at
        if @@car_status == "Available" && @order.save
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
