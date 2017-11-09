class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end


  def create
    @order = current_order
    @order.update_attributes(order_params)
    if @order.update_attributes(order_params)
      session[:order_id] = @order.id
      @order.save
    else
      redirect_to root_path
      flash[:info] = "Opps we have some problems with order"
    end
  end

  def show
    @order = current_user.orders.where(status: 'Compleate')
    @orders = current_order
  end

  def status
    @status=current_order.update_attributes(status: params[:status])
    current_order.save
  end

  private
  def order_params
    params.require(:order).permit(:product_id, :quantity, :status)
  end


end