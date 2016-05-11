FactoryGirl.define do
  factory :order do
    status { Order::STATUSES.sample }
    date Date.today
    total_price { rand 1000 }
    client
    provider
  end
end
