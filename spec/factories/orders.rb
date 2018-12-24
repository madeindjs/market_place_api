# spec/factories/orders.rb
FactoryBot.define do
  factory :order do
    user { nil }
    total { 0 }
  end
end
