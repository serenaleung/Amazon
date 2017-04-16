require 'rails_helper'

RSpec.describe Review, type: :model do

 def review_attr(review_attributes = {})
 { rating: 2,
   body: 'this sucks'
  #  title: 'something terrible',
 }.merge(review_attributes)

end

it 'has a required rating' do
 revew = Review.new review_attr(rating:2)
 expect(:rating).to_not eq(nil)
end

it 'has more than 0 stars and less than 6 stars' do
  review = Review.new review_attr(rating: 2)
  review.save
  #expect(review).to be_valid

  expect(review.rating).to be_between(1, 5).inclusive
end

 it "raises a validation if rating is not between 1 and 5" do
  review = Review.new review_attr rating: 10
  review.save
  expect(review.errors.messages).to have_key(:rating)
 end
end
