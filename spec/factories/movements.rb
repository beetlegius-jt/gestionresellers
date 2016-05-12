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

FactoryGirl.define do
  factory :movement do
    ammount { rand 1000.00 }
    order
    client
  end
end
