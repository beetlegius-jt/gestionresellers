# == Schema Information
#
# Table name: articles
#
#  id            :integer          not null, primary key
#  serial_number :string
#  in_stock      :boolean          default(TRUE)
#  product_id    :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Article, type: :model do
  subject(:article) { FactoryGirl.build(:article) }
  # let(:article_sold) { FactoryGirl.build(:article_sold) }

  ####################
  # VALIDATIONS
  ####################

  describe "is invalid" do
    after(:example) { expect(article).not_to be_valid }

    it 'without a product' do
      article.product = nil
    end

    it 'without a serial number' do
      article.serial_number = nil
    end

    it 'without an uniqueness serial number' do
      article_repeated = FactoryGirl.create(:article)
      article.serial_number = article_repeated.serial_number
    end
  end

end
