class OrdersController < ApplicationController
  before_action :set_product
  before_action :build_order, only: [:create]

  def index
    @orders = product_orders.where(user: current_user)
  end

  def show
    @order = product_orders.find(params[:id])
    authorize_user!
  end

  def create
    @order = product_orders.build(order_params.merge(user: current_user))
    if @order.save
      redirect_to [@product, @order], notice: "Order placed successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
    product_orders = @product.orders
  end

  def authorize_user!
    redirect_to products_path, alert: "Not authorized" unless @order.user == current_user
  end

  def order_params
    params.require(:order).permit(:quantity, :status)
  end
end
