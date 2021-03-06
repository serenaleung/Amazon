class Product < ApplicationRecord

  belongs_to :category
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :products, dependent: :nullify

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings


  before_save :capitalize_title
#
#
  validates(:title, { presence: { message: 'must be present!' },
                      uniqueness: true })
  validates(:description,{ presence: true,})
                    # numericality: {greater_than_or_equal_to: 10 }
  validates(:price, { presence: true,
                      numericality: { greater_than_or_equal_to: 0 }})
#
#   # validate :description_length
#
#   def self.search(string)
#     where(['title ILIKE ? OR body ILIKE ?', "%#{string}%", "%#{string}%"]).order(['body ILIKE ?', "%#{string}%"], ['title ILIKE ?', "%#{string}%"])
#   end

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history, :finders]

#
#
end
#
#
private
#
  def set_defaults
    self.price ||= 1
  end
#
  def capitalize_title
    # self.title = title.capitalize if title.present?
    self.title.capitalize!
  end

  # def description_length
  #  if(description.present? && description.length < 10)
  #    errors.add(:description, 'description is shorter than 10 characters')
  #  end
# end
