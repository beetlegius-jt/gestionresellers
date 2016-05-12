# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  role                   :string
#  client_id              :integer
#  provider_id            :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "user#{i}@xaver.com.ar" }
    password "secret"
    password_confirmation "secret"
    provider

    factory :user_client do
      role User::CLIENT
      client
    end

    factory :user_provider do
      role User::PROVIDER
    end

    factory :user_admin do
      role User::ADMIN
      client nil
      provider nil
    end
  end
end
