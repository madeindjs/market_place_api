# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :user
  has_many :placements
  has_many :products, through: :placements
  validates :total, numericality: { greater_than_or_equal_to: 0.0 }, presence: true
  validates :user_id, presence: true
  validates_with EnoughProductsValidator

  before_validation :set_total!

  def set_total!
    self.total = 0.0
    placements.each do |placement|
      self.total += placement.product.price.to_f * placement.quantity
    end
  end

  # @param product_ids_and_quantities [Array] something like this
  #        `[[product_1.id, 2], [product_2.id, 3]]`. Where first item is
  #        `product_id` and the second is the quantity
  def build_placements_with_product_ids_and_quantities(product_ids_and_quantities)
    product_ids_and_quantities.each do |product_id_and_quantity|
      product_id, quantity = product_id_and_quantity # [1,5]
      placements.build(product_id: product_id, quantity: quantity)
    end
  end
end
