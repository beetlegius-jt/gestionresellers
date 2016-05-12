# == Schema Information
#
# Table name: articles
#
#  id            :integer          not null, primary key
#  serial_number :string
#  in_stock      :boolean          default(TRUE)
#  product_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Article < ApplicationRecord

  # CONFIG

  belongs_to :product
  belongs_to :order, required: false

  # CALLBACKS

  # VALIDATIONS

  validates :serial_number, presence: true, uniqueness: true

  # SCOPES

  # CLASS METHODS

  # INSTANCE METHODS

  # ALIAS

  # PRIVATE

  private

end
