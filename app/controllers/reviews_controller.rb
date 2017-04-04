class ReviewsController < ApplicationController
  def create
    @product = Product.find params[:product_id]
    review_params = params.require(:review).permit(:rating, :body)
    @review = Review.new review_params
    @review.product = @product

    if @review.save
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
