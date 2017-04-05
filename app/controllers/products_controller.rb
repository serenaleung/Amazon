class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @product = Product.new
    # @reviews = Reviews.new
  end

  def create
    product_params = params.require(:product).permit([:title, :description, :price, :category_id])
    @product = Product.new product_params
    @product.user = current_user

    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def show
    @product = Product.find params[:id]
    @review = Review.new
  end

  def index
    @products = Product.last(20)
  end

  def edit
    @product = Product.find params[:id]
  end

  def update
    @product = Product.find params[:id]
    product_params = params.require(:product).permit([:title, :description, :price, :category_id])

    if @product.user != current_user
      flash[:alert] = "You cannot change a product that you did not create"
      redirect_to product_path(@product)
    elsif @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    product = Product.find params[:id]
    product.destroy
    redirect_to products_path
  end

  private
  def find_product
    @product = Product.find params[:id]
  end

  def product_params
    params.require(:product).permit([:title, :description, :price, :category_id])
  end

end
