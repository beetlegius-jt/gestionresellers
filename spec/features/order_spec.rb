require 'rails_helper'

feature Order, type: :feature do
  let(:user_client) { FactoryGirl.create(:user_client) }
  let(:user_provider) { FactoryGirl.create(:user_provider) }

  let!(:order) { FactoryGirl.create(:order, client: user_client.client, provider: user_provider.provider) }
  let!(:old_order) { FactoryGirl.create(:order, date: 61.days.ago, client: user_client.client, provider: user_provider.provider) }
  let!(:provider_order) { FactoryGirl.create(:order, provider: user_provider.provider) }
  let!(:external_order) { FactoryGirl.create(:order) }

  describe 'history' do
    context 'as a client' do
      before(:example) do
        login_as user_client, scope: :user
        visit orders_path
      end

      it 'shows the basic information of each order' do
        expect(page).to have_selector("#order_#{order.id}")
        expect(page).to have_content(order.date)
        expect(page).to have_content(order.total_price)
        expect(page).to have_content(order.status)
      end

      it 'shows only the last 60 days orders' do
        expect(page).not_to have_selector("#order_#{old_order.id}")
      end

      it 'shows only the current client orders' do
        expect(page).not_to have_selector("#order_#{provider_order.id}")
        expect(page).not_to have_selector("#order_#{external_order.id}")
      end
    end

    context 'as a provider' do
      before(:example) do
        login_as user_provider, scope: :user
        visit orders_path
      end

      it 'shows the basic information of each order' do
        expect(page).to have_selector("#order_#{order.id}")
        expect(page).to have_content(order.date)
        expect(page).to have_content(order.total_price)
        expect(page).to have_content(order.status)
      end

      it 'shows only the last 60 days orders' do
        expect(page).not_to have_selector("#order_#{old_order.id}")
      end

      it 'shows only the current client provider' do
        expect(page).to have_selector("#order_#{provider_order.id}")
        expect(page).not_to have_selector("#order_#{external_order.id}")
      end
    end
  end

  describe 'show order' do
    context 'as a client' do
      before(:example) do
        login_as user_client, scope: :user
        visit order_path(order)
      end

      it 'shows its full information' do
        expect(page).to have_content(order.id)
        expect(page).to have_content(order.date)
        expect(page).to have_content(order.total_price)
        expect(page).to have_content(order.status)
        expect(page).to have_content(order.client.name)
        expect(page).to have_content(order.provider.name)
      end

      it 'shows its items full information' do
        for item in order.items
          expect(page).to have_content(item.product.name)
          expect(page).to have_content(item.unit_price)
          expect(page).to have_content(item.quantity)
        end
      end
    end
  end

end
