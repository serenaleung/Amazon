class Admin::DashboardController < ApplicationController
  def index
    @product = Product.count
    @review = Review.count
    @user = User.count
    @products = Product.all
    @users = User.all
  end
end
