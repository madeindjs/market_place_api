# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :user
  has_many :placements
  has_many :products, through: :placements
  validates :total, numericality: { greater_than_or_equal_to: 0 }
  validates :total, presence: true
  validates :user_id, presence: true

  before_validation :set_total!

  def set_total!
    self.total = products.map(&:price).sum
  end
end
