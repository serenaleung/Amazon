class LikesController < ApplicationController
  before_action :authenticate_user!

  # def create
  #   like        = Like.new
  #   review      = Review.find params [:review_id]
  #   like.review = review
  #   like.user   = current_user
  #   if like.save
  #     redirect_to review_path(review), notice: "Thanks for liking!"
  #     redirect_to review_path(review), alert: "Liked already! >=("
  #   end
  #   if cannot? :like, review
  #     redirect_to review_path(review), alert: 'Liking your own review is disgusting'
  #     return # early return to prevent execution of anything
  #     # after redirect above
  #   end
  # end

  def index
    user = User.find(params[:user_id])
    @reviews = user.liked_reviews

    render 'reviews/index'
  end

  def create
    review = Review.find(params[:review_id])
    product = review.product
    like = Like.new(user: current_user, review: review)
    if like.save
      redirect_to product_path(product), notice: 'Review liked! 💖'
    else
      redirect_to product_path(product), alert: like.errors.full_messages.join(', ')
    end
  end

  def destroy
    review = Review.find params[:review_id]
    product = review.product
    like   = current_user.likes.find params[:id]
    like.destroy
    redirect_to product_path(product), notice: "Like removed!"
  end
end
