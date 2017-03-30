class ProductsController < ApplicationController

  def new
    @product = Product.new
  end

  def create
    product_params = params.require(:product).permit([:title, :body, :price])
    @product = Product.new product_params
    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def show
    @product = Product.find params[:id]
  end

  def index
    @products = Product.last(20)
  end

  def edit
    @product = Product.find params[:id]
  end

  def update
    @product = Product.find params[:id]
    product_params = params.require(:product).permit([:title, :body, :price])

    if @product.update(product_params)
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


end
