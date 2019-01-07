# app/serializers/user_serializer.rb
class UserSerializer < ActiveModel::Serializer
  type :user
  attributes :id, :email, :created_at, :updated_at, :auth_token
  has_many :products

  attribute :product_ids do
    object.products.map(&:id)
  end
end
