# app/serializers/product_serializer.rb
class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :price, :published
end
