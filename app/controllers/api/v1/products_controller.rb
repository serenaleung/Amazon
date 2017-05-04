class Api::V1::ProductsController < ApplicationController
  before_action :authenticate_user
  def index
    @products = Product.last(20)

    render json: @products
  end

  def show
    product = Product.find params[:id]
    render json: product
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
