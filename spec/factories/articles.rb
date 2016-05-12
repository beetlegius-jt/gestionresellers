# == Schema Information
#
# Table name: articles
#
#  id            :integer          not null, primary key
#  serial_number :string
#  in_stock      :boolean          default(TRUE)
#  order_id      :integer
#  product_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :article do
    serial_number { SecureRandom.hex }
    in_stock true
    product

    factory :article_sold do
      in_stock false
    end
  end
end
