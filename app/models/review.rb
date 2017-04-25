class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user

  validates(:rating, { presence: true,
                       numericality: { less_than_or_equal_to: 5 }})

  def liked_by?(user)
    likes.find_by_user_id(user.id).present?
  end

  def like_for(user)
   likes.find_by(user: user)
  end

  def votes_count
    votes.where(is_up: true).count - votes.where(is_up: false).count
  end
end
