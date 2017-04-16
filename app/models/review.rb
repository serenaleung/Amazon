class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user, optional: true
  
  validates(:rating, { presence: true,
                       numericality: { less_than_or_equal_to: 5 }})

end
