class Product < ApplicationRecord

  # CONFIG

  STATUSES = [AVAILABLE = 'available', UNAVAILABLE = 'unavailable']

  belongs_to :provider

  dragonfly_accessor(:image)

  # CALLBACKS

  # VALIDATIONS

  validates :name, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :package_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # SCOPES

  # CLASS METHODS

  # INSTANCE METHODS

  # ALIAS

  # PRIVATE

  private

end
