# spec/factories/orders.rb
FactoryBot.define do
  factory :order do
    user
    total { 0 }
  end
end
