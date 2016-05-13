# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  unit_price :decimal(15, 2)
#  quantity   :integer          default(1)
#  product_id :integer
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Item < ApplicationRecord

  # CONFIG

  belongs_to :product
  belongs_to :order

  # CALLBACKS

  # VALIDATIONS

  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { greater_than: 0 }

  # SCOPES

  # CLASS METHODS

  # INSTANCE METHODS

  def price
    unit_price * quantity
  end

  def can_be_prepared?
    product.articles.in_stock.count >= quantity
  end

  def associate_articles_to_order
    self.order.articles << product.articles.in_stock.limit(quantity)
  end

  # ALIAS

  # PROTECTED

  protected

end
