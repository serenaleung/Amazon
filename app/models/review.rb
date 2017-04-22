class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  validates(:rating, { presence: true,
                       numericality: { less_than_or_equal_to: 5 }})

  def liked_by?(user)
    likes.find_by_user_id(user.id).present?
  end

  def like_for(user)
   likes.find_by(user: user)
  end
end
