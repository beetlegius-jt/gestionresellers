FactoryGirl.define do
  factory :product do
    sequence(:name) { |i| "Product #{i}" }
    status 'available'
    description 'Best product ever'
    image_uid nil
    price { rand(100.00) }
    provider

    factory :package_product do
      package_quantity 20
      package_price { self.price * 0.9 }
    end

  end
end
