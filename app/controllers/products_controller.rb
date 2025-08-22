class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action: build_product, only: [:new, :create]

  def index
    @products = Product.all
  end

  def show; end

  def new; end

  def create
    @product.assign_attributes(product_params)
    if @product.save
      redirect_to @product, notice: "Product created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize_user!
  end

  def update
    authorize_user!
    if @product.update(product_params)
      redirect_to @product, notice: "Product updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize_user!
    @product.destroy
    redirect_to products_path, notice: "Product deleted successfully."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def authorize_user!
    redirect_to products_path, alert: "Not authorized" unless @product.user == current_user
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :category, :available)
  end

  def build_product
    @product = current_user.products.build
  end
end
