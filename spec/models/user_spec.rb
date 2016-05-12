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

require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:user) { FactoryGirl.build(:user) }

  ####################
  # VALIDATIONS
  ####################

  describe 'is invalid' do
    after(:example) { expect(user).not_to be_valid }

    it 'without email' do
      user.email = nil
    end

    it 'without password' do
      user.password = nil
      user.password_confirmation = nil
    end

    it 'with a different password and password_confirmation' do
      user.password = 'foofoofoo'
      user.password_confirmation = 'barbarbar'
    end

    it 'without a role' do
      user.role = nil
    end

    it 'without an included role' do
      user.role = SecureRandom.hex
    end

    context 'being of role client' do
      subject(:user) { FactoryGirl.build(:user_client) }

      it 'without a provider' do
        user.provider = nil
      end

      it 'without a client' do
        user.client = nil
      end
    end

    context 'being of role provider' do
      subject(:user) { FactoryGirl.build(:user_provider) }

      it 'without a provider' do
        user.provider = nil
      end

      it 'with a client' do
        user.client = FactoryGirl.create(:client)
      end
    end

    context 'being of role admin' do
      subject(:user) { FactoryGirl.build(:user_admin) }

      it 'with a provider' do
        user.provider = FactoryGirl.create(:provider)
      end

      it 'with a client' do
        user.client = FactoryGirl.create(:client)
      end

    end
  end

  ####################
  # RELATIONS
  ####################

  it 'belongs to client' do
    expect(user).to respond_to(:client)
  end

  it 'belongs to provider' do
    expect(user).to respond_to(:provider)
  end

  ####################
  # CALLBACKS
  ####################

  it 'sets a default role on initialize' do
    user = FactoryGirl.build(:user)
    expect(user.role).to eq(User::CLIENT)
  end

end
