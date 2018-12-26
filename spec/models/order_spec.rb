# spec/models/order_spec.rb
require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { FactoryBot.build :order }
  subject { order }

  it { should respond_to(:total) }
  it { should respond_to(:user_id) }

  it { should validate_presence_of :user_id }

  it { should belong_to :user }

  it { should have_many(:placements) }
  it { should have_many(:products).through(:placements) }

  describe '#set_total!' do
    before(:each) do
      @order = FactoryBot.build :order
      @order.products << FactoryBot.create(:product, price: 100)
      @order.products << FactoryBot.create(:product, price: 85)
    end

    it 'returns the total amount to pay for the products' do
      expect { @order.set_total! }.to change { @order.total }.from(0).to(185)
    end
  end
end
