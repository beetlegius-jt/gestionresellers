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

FactoryGirl.define do
  factory :client do
    sequence(:name) { |i| "Client #{i}" }
  end
end
