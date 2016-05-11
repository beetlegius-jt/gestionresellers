class Order < ApplicationRecord

  # CONFIG

  STATUSES = [PENDING = 'pending', WAITING_PAYMENT = 'waiting_payment', PREPARED = 'prepared', CLOSED = 'closed']

  belongs_to :client
  belongs_to :provider

  # CALLBACKS

  # VALIDATIONS

  validates :status, presence: true, inclusion: { in: STATUSES }

  # SCOPES

  # CLASS METHODS

  # INSTANCE METHODS

  # ALIAS

  # PRIVATE

  private

end
