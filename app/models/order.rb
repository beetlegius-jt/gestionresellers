class Order < ApplicationRecord

  # CONFIG

  STATUSES = [PENDING = 'pending', WAITING_PAYMENT = 'waiting_payment', PREPARED = 'prepared', CLOSED = 'closed']

  belongs_to :client
  belongs_to :provider

  # CALLBACKS

  # VALIDATIONS

  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }

  # SCOPES

  # CLASS METHODS

  # INSTANCE METHODS

  # ALIAS

  # PRIVATE

  private

end
