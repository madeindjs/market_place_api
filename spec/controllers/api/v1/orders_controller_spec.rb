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
      expect(json_response).to have(4).items
    end

    it { expect(response.response_code).to eq(200) }
  end
end
