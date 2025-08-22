class Order < ApplicationRecord
  STATUSES = %w[pending paid shipped cancelled]
  belongs_to :user
  belongs_to :product
  
  validates :quantity, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: STATUSES } 
  before_save :set_total_price

  private

  def set_total_price
    self.total_price = product.price * quantity
  end
end
