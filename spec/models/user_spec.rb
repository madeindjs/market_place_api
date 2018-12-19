# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryBot.build(:user) }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

  it { should respond_to(:auth_token) }
  it { should validate_uniqueness_of(:auth_token) }

  it { should validate_uniqueness_of(:auth_token) }

  it { should have_many(:products) }

  describe '#generate_authentication_token!' do
    it 'generates a unique token' do
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to be_nil
    end

    it 'generates another token when one already has been taken' do
      existing_user = FactoryBot.create(:user, auth_token: 'auniquetoken123')
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql existing_user.auth_token
    end
  end

  describe '#products association' do
    before do
      @user.save
      3.times { FactoryBot.create :product, user: @user }
    end

    it 'destroys the associated products on self destruct' do
      products = @user.products
      @user.destroy
      products.each do |product|
        expect { Product.find(product.id) }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
