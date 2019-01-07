# app/serializers/order_serializer.rb
class OrderSerializer < ActiveModel::Serializer
  type :order
  attributes :id, :total
  has_many :products, serializer: OrderProductSerializer
  cache key: 'order', expires_in: 3.hours
end
