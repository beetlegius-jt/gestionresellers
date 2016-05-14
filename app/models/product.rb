# == Schema Information
#
# Table name: products
#
#  id               :integer          not null, primary key
#  name             :string
#  image_uid        :string
#  status           :string
#  description      :text
#  package_quantity :integer
#  price            :decimal(15, 2)
#  package_price    :decimal(15, 2)
#  provider_id      :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Product < ApplicationRecord

  # CONFIG

  STATUSES = [AVAILABLE = 'available', UNAVAILABLE = 'unavailable']

  belongs_to :provider
  has_many :articles, dependent: :destroy

  dragonfly_accessor(:image)

  # CALLBACKS

  # VALIDATIONS

  validates :name, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :package_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # SCOPES

  scope :search, -> (search) { where "name ILIKE :search", search: "%#{search}%" }

  # CLASS METHODS

  # INSTANCE METHODS

  # ALIAS

  # PROTECTED

  protected

end
