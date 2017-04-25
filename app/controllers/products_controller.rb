class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!, except: [:index, :show]

  def new
    @product = Product.new
    # @reviews = Reviews.new
  end

  def create
    product_params = params.require(:product).permit([:title, :description, :price, :category_id, {tag_ids: [] } ])
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
    if !(can? :edit, @product)
      redirect_to root_path, alert: 'access denied'
    elsif @product.update(product_params)
      redirect_to product_path(@product), notice: 'Product updated'
    else
      render :edit
    end
  end

  def destroy
    # product = Product.find params[:id]
    # product.destroy

    # local variable because only redirecting
    # only need instance variables if sharing with a template
    if can? :destroy, @product
      @product.destroy
      redirect_to products_path, notice: 'Product deleted'
    else
      redirect_to root_path, alert: 'access denied'
    end
    # render plain: 'in products destroy'
  end

  private
  def find_product
    @product = Product.find params[:id]
  end

  def product_params
    params.require(:product).permit([:title, :description, :price, :category_id])
  end

end
