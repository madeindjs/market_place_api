# app/models/user.rb
class User < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :auth_token, uniqueness: true
  before_create :generate_authentication_token!

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end
end
