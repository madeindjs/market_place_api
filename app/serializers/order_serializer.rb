# app/serializers/order_serializer.rb
class OrderSerializer < ActiveModel::Serializer
  type :order
  attributes :id, :total
  has_many :products, serializer: OrderProductSerializer
end
