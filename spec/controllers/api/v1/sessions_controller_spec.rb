# frozen_string_literal: true

# spec/controllers/api/v1/sessions_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe 'POST #create' do
    before(:each) do
      @user = FactoryBot.create :user
    end

    context 'when the credentials are correct' do
      before(:each) do
        post :create, params: {
          session: { email: @user.email, password: '12345678' }
        }
      end

      it 'returns the user record corresponding to the given credentials' do
        @user.reload
        expect(json_response[:auth_token]).to eql @user.auth_token
      end

      it { expect(response.response_code).to eq(200) }
    end

    context 'when the credentials are incorrect' do
      before(:each) do
        post :create, params: {
          session: { email: @user.email, password: 'invalidpassword' }
        }
      end

      it 'returns a json with an error' do
        expect(json_response[:errors]).to eql 'Invalid email or password'
      end

      it { expect(response.response_code).to eq(422) }
    end
  end

  describe "DELETE #destroy" do

    before(:each) do
      @user = FactoryBot.create :user
      sign_in @user
      delete :destroy, params: { id: @user.auth_token }
    end

    it { expect(response.response_code).to eq(204) }

  end
end
