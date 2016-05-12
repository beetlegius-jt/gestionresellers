# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  status      :string
#  date        :date
#  client_id   :integer
#  provider_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Order < ApplicationRecord

  class CannotBePrepared < StandardError
  end

  class CannotBeClosed < StandardError
  end

  # CONFIG

  STATUSES = [WAITING_PAYMENT = 'waiting_payment', PREPARED = 'prepared', CLOSED = 'closed']

  belongs_to :client
  belongs_to :provider

  has_many :items, dependent: :destroy
  has_many :articles
  has_one :movement

  # CALLBACKS

  after_initialize :set_default_status

  # VALIDATIONS

  validates :status, presence: true, inclusion: { in: STATUSES }

  # SCOPES

  # CLASS METHODS

  # INSTANCE METHODS

  def total_price
    items.map(&:price).sum
  end

  def mark_as_prepared
    if can_be_prepared?
      update status: PREPARED
      # Reserve articles
    else
      raise CannotBePrepared.new("The client has to pay first")
    end
  end

  def mark_as_closed
    if can_be_closed?
      update status: CLOSED
    else
      raise Order::CannotBeClosed.new("The order is not prepared")
    end
  end

  # ALIAS

  # PRIVATE

  private

  def set_default_status
    self.status ||= WAITING_PAYMENT
  end

  def can_be_prepared?
    status == WAITING_PAYMENT && movement.present?
  end

  def can_be_closed?
    status == PREPARED
  end

end
