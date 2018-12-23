# spec/models/placement_spec.rb
require 'rails_helper'

RSpec.describe Placement, type: :model do
  let(:placement) { FactoryBot.build :placement }
  subject { placement }

  it { should respond_to :order_id }
  it { should respond_to :product_id }

  it { should belong_to :order }
  it { should belong_to :product }
end
