class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :tag_ids

  belongs_to :user
  has_many :reviews
  # { author: [:bio], comments: [:author]] }

  class UserSerializer < ActiveModel::Serializer
    attributes :first_name
  end
end
