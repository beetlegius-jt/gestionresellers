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

FactoryGirl.define do
  factory :order do
    date { rand 60.days.ago.to_date..Date.today }
    client
    provider
  end
end
