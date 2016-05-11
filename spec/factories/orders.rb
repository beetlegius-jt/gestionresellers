FactoryGirl.define do
  factory :order do
    status { Order::STATUSES.sample }
    date Date.today
    client
    provider
  end
end
