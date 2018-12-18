# spec/models/product_spec.rb
require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { FactoryBot.build :product }
  subject { product }

  it { should respond_to(:title) }
  it { should respond_to(:price) }
  it { should respond_to(:published) }
  it { should respond_to(:user_id) }
end
