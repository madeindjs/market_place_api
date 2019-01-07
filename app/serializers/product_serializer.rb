# app/serializers/product_serializer.rb
class ProductSerializer < ActiveModel::Serializer
  type :product
  attributes :id, :title, :price, :published
  belongs_to :user
  cache key: 'product', expires_in: 3.hours
end
