class Admin::DashboardController < ApplicationController
  before_action :authorize_admin

  def index
    @product = Product.count
    @review = Review.count
    @user = User.count
    @products = Product.all
    @users = User.all
  end


end
