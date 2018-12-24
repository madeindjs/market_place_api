# app/serializers/order_product_serializer.rb
class OrderProductSerializer < ProductSerializer
  def include_user?
    false
  end
end
