# == Schema Information
#
# Table name: movements
#
#  id         :integer          not null, primary key
#  ammount    :decimal(15, 2)
#  order_id   :integer
#  client_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Movement < ApplicationRecord

  # CONFIG

  belongs_to :client
  belongs_to :order, required: false

  # CALLBACKS

  after_create  { client.update_account_balance }
  after_destroy { client.update_account_balance }

  # VALIDATIONS

  validates :ammount, presence: true, numericality: true

  # SCOPES

  # CLASS METHODS

  # INSTANCE METHODS

  # ALIAS

  # PROTECTED

  protected

end
