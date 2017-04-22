class ReviewsMailer < ApplicationMailer
  def notify_product_owner(review)
      # you can share instance varaibales with templates the same way we do with
      # rails controllers
      @review = review
      @product = review.product
      @user = @review.user #.user because in product.rb you wrote product belongs to user

      # this will render app/views/reviews_mailer/notify_product_owner.html.erb
      # and/or app/views/reviews_mailer/notify_product_owner.text.erb
      # mail(to: 'serenaleung1@gmail.com', subject: 'Test email')
      mail(to: @user.email, subject: 'You got an answer!') if @user
    end
end
