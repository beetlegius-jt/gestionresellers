FactoryGirl.define do
  factory :client do
    sequence(:name) { |i| "Client #{i}" }
    account_balance { rand(10000) }
  end
end
