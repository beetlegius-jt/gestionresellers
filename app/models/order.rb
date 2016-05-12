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
      items.each(&:associate_articles_to_order)
    else
      raise CannotBePrepared.new("Please check for stock of all the items and if the customer has already paid.")
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
    status == WAITING_PAYMENT && movement.present? && items.all?(&:can_be_prepared?)
  end

  def can_be_closed?
    status == PREPARED
  end

end
