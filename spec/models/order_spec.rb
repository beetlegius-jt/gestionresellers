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

require 'rails_helper'

RSpec.describe Order, type: :model do

  subject(:order) { FactoryGirl.build(:order) }

  ####################
  # VALIDATIONS
  ####################

  describe 'is invalid' do
    after(:example) { expect(order).not_to be_valid }

    it 'without a client' do
      order.client = nil
    end

    it 'without a provider' do
      order.provider = nil
    end

    it 'without a status' do
      order.status = nil
    end

    it 'without an included status' do
      order.status = SecureRandom.hex
    end

  end

  it 'default status is waiting payment' do
    expect(order.status).to eq(Order::WAITING_PAYMENT)
  end

  ####################
  # RELATIONS
  ####################

  it 'belongs to client' do
    expect(order).to respond_to(:client)
  end

  it 'belongs to provider' do
    expect(order).to respond_to(:provider)
  end

  it 'has many items' do
    expect(order).to respond_to(:items)
  end

  it 'has one movement' do
    expect(order).to respond_to(:movement)
  end

  it 'has many articles' do
    expect(order).to respond_to(:articles)
  end

  ####################
  # CALLBACKS
  ####################

  describe 'destroy all the associated' do
    subject(:order) { FactoryGirl.create(:order) }

    it 'items after destroy' do
      10.times do
        order.items << FactoryGirl.build(:item)
      end
      expect { order.destroy }.to change { Item.count }.by -10
    end
  end

  ####################
  # METHODS
  ####################

  context '#mark_as_prepared' do
    before(:example) do
      order.status = Order::WAITING_PAYMENT
      order.movement = FactoryGirl.build(:movement)
      10.times do
        order.items << FactoryGirl.build(:item)
      end
    end

    it 'respond to method' do
      expect(order).to respond_to(:mark_as_prepared)
    end

    it 'can be prepared only if was payed' do
      order.movement = nil
      expect { order.mark_as_prepared }.to raise_exception { Order::CannotBePrepared }
    end

    it 'can be prepared only if was waiting payment' do
      order.status = Order::PREPARED
      expect { order.mark_as_prepared }.to raise_exception { Order::CannotBePrepared }
    end

    it 'reserve the correct ammount of articles' do
      pending
      expect { order.mark_as_prepared }.to change { order.articles.count }.from(0).to(order.items.sum(:quantity))
    end

    it 'changes status to prepared' do
      order.movement = FactoryGirl.create(:movement)
      expect { order.mark_as_prepared }.to change { order.status }.from(Order::WAITING_PAYMENT).to(Order::PREPARED)
    end
  end

  context '#mark_as_closed' do
    before(:example) do
      order.status = Order::PREPARED
      order.movement = FactoryGirl.build(:movement)
      order.items << FactoryGirl.build(:item)
    end

    it 'respond to method' do
      expect(order).to respond_to(:mark_as_closed)
    end

    it 'can be closed only if was prepared' do
      order.status = Order::WAITING_PAYMENT
      expect { order.mark_as_closed }.to raise_exception { Order::CannotBeClosed }
    end

    it 'changes status to closed' do
      expect { order.mark_as_closed }.to change { order.status }.from(Order::PREPARED).to(Order::CLOSED)
    end
  end

end
