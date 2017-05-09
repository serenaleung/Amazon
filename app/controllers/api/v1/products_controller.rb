class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_user
  skip_before_filter :verify_authenticity_token
  def index
    @products = Product.all.order(created_at: 'DESC')

    # render json: @products
  end

  def show
    @product = Product.find params[:id]
    # render json: product
  end

  def create
    product_params =
    params.require(:product).permit(:title, :description, :price)
      product = Product.new product_params
      product.user = @user
      if product.save
        head :ok
      else
        render json: {error: product.errors.full_messages.join(', ')}
      end
    # @product = Product.new title: params[:title], description: params[:description], price: params[:price]
    # @product.user = @user
    #   if @product.save
    #     render json: {result: 'product created'}
    #   else
    #     render json: {result: @product.errors.full_messages.join(', ')}
    #   end
  end

  private
  def authenticate_user
    @user = User.find_by_api_token params[:api_token]
    # head will send an empty HTTP response with a code that is inferred by the
    # symbol you pass as an argument to the `head` method
    # http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/
    head :unauthorized if @user.nil?
  end
end
