FactoryGirl.define do
  factory :product do
    sequence(:title) {|t| "Cool Product Title #{t}"}
    description 'Some description of this product'
    price 100
    # sale_price 70
  end
end
