class Product < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy

  validates :name, presence: true, length: { in: 3..20 }
  validates :description, length: { maximum: 300 }, allow_blank: true
  validates :price, numericality: { greater_than: 0 }
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
  validates :category, inclusion: { in: %w[Electronics Clothing Home Beauty Sports Others] }, allow_blank: true

  scope :available, -> { where(available: true).where('stock > ?', 0) }
  scope :by_category, ->(value) { where(category: value) }

  before_save :mark_unavailable_if_out_of_stock

  def discounted_price(discount)
    (price - (price * discount / 100.0)).round(2)
  end

  private

  def mark_unavailable_if_out_of_stock
    self.available = false if stock <= 0
  end
end
