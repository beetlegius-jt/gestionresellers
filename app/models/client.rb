# == Schema Information
#
# Table name: clients
#
#  id              :integer          not null, primary key
#  name            :string
#  account_balance :decimal(15, 2)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Client < ApplicationRecord

  # CONFIG

  has_many :orders, dependent: :destroy
  has_many :movements, dependent: :destroy
  has_many :users, dependent: :destroy

  # CALLBACKS

  # VALIDATIONS

  validates :name, presence: true
  validates :account_balance, numericality: { greater_than_or_equal_to: 0 }

  # SCOPES

  # CLASS METHODS

  # INSTANCE METHODS

  def pay(order)
    movements.create ammount: -order.total_price.abs, order: order
  end

  def receive_payment(ammount)
    movements.create ammount: ammount.abs
  end

  def update_account_balance
    update account_balance: calculate_account_balance
  end

  def main_user
    users.first
  end

  # ALIAS

  # PROTECTED

  protected

  def calculate_account_balance
    movements.sum(:ammount)
  end
end
