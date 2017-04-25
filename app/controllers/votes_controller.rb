class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    review = Review.find params[:review_id]
    vote   = Vote.new is_up: params[:is_up],
                      user: current_user,
                      review: review
    if vote.save
      redirect_to product_path(vote.review.product), notice: 'Yay'
    else
      redirect_to product_path(vote.review.product), alert: vote.errors.full_messages.join(', ')
    end
  end

  def destroy
    # vote = Vote.find params[:id]
    vote = Vote.find params[:id]
    vote.destroy
    redirect_to product_path(vote.review.product), notice: 'Unvoted!'
  end

  def update
  	vote = Vote.find params[:id]
  	vote.is_up = params[:is_up]
  	if vote.save
      redirect_to product_path(vote.review.product), notice: 'Vote changed'
    else
  	  redirect_to product_path(vote.review.product), alert: vote.errors.full_messages.join(', ')
    end
  end
end
