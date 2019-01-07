# spec/controllers/api/v1/orders_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do
  describe 'GET #index' do
    before(:each) do
      current_user = FactoryBot.create :user
      api_authorization_header current_user.auth_token
      4.times { FactoryBot.create :order, user: current_user }
      get :index, params: { user_id: current_user.id }
    end

    it 'returns 4 order records from the user' do
      expect(json_response[:data]).to have(4).items
    end

    it { expect(response.response_code).to eq(200) }
  end

  describe 'GET #show' do
    before(:each) do
      current_user = FactoryBot.create :user
      api_authorization_header current_user.auth_token
      @product = FactoryBot.create :product
      @order = FactoryBot.create :order, user: current_user, products: [@product]
      get :show, params: { user_id: current_user.id, id: @order.id }
    end

    it 'returns the user order record matching the id' do
      expect(json_response[:data][:id].to_i).to eql @order.id
    end

    it 'includes the total for the order' do
      expect(json_response[:data][:attributes][:total]).to eql @order.total.to_s
    end

    it 'includes the products on the order' do
      expect(json_response[:data][:relationships][:products][:data]).to have(1).item
    end

    it { expect(response.response_code).to eq(200) }
  end

  describe 'POST #create' do
    before(:each) do
      current_user = FactoryBot.create :user
      api_authorization_header current_user.auth_token

      product_1 = FactoryBot.create :product
      product_2 = FactoryBot.create :product
      order_params = {
        product_ids_and_quantities: [[product_1.id, 2], [product_2.id, 3]]
      }
      post :create, params: { user_id: current_user.id, order: order_params }
    end

    it 'returns the just user order record' do
      expect(json_response[:data][:id]).to be_present
    end

    it 'embeds the two product objects related to the order' do
      expect(json_response[:data][:relationships][:products][:data].size).to eql 2
    end

    it { expect(response.response_code).to eq(201) }
  end
end
