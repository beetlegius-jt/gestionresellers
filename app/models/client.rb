class Client < ApplicationRecord

  # CONFIG

  has_many :orders, dependent: :destroy

  # CALLBACKS

  # VALIDATIONS

  validates :name, presence: true
  validates :account_balance, numericality: { greater_than_or_equal_to: 0 }

  # SCOPES

  # CLASS METHODS

  # INSTANCE METHODS

  # ALIAS

  # PRIVATE

  private

end
