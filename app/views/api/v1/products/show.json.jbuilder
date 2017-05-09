json.title @product.title
json.description @product.description
json.price @product.price


json.id @product.id
json.title @product.title.titleize
json.created_on @product.created_at.strftime('%Y-%B-%d')
json.description @product.description
json.reviews @product.reviews do |review|
  json.id review.id
  json.body review.body
end
