class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product

  def index
    @orders = @product.orders.where(user: current_user)
  end

  def show
    @order = @product.orders.find(params[:id])
    authorize_user!
  end

  def create
    @order = @product.orders.build(order_params.merge(user: current_user))
    if @order.save
      redirect_to [@product, @order], notice: "Order placed successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def authorize_user!
    redirect_to products_path, alert: "Not authorized" unless @order.user == current_user
  end

  def order_params
    params.require(:order).permit(:quantity, :status)
  end
end
