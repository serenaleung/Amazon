class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @product = Product.find params[:product_id]
    review_params = params.require(:review).permit(:rating, :body)
    @review = Review.new review_params
    @review.product = @product

    @review.user = current_user

    if @review.save
      #sending an email to the question's owner
      ReviewsMailer.notify_product_owner(@review).deliver_now
      redirect_to product_path(@product), notice: 'Review Created!'
    else
      flash.now[:alert] = "#{@review.errors.full_messages.join(', ')}"
      render '/products/show'
    end
  end

  def destroy
    @product = Product.find params[:product_id]
    @review = Review.find params[:id]
    @review.destroy
  redirect_to product_path(@product), notice: 'Review Deleted'
  end

end
