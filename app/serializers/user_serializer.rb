# app/serializers/user_serializer.rb
class UserSerializer < ActiveModel::Serializer
  type :user
  attributes :id, :email, :created_at, :updated_at, :auth_token
  has_many :products
  cache key: 'user', expires_in: 3.hours

  attribute :product_ids do
    object.products.map(&:id)
  end
end
