class Provider < ApplicationRecord

  # CONFIG

  has_many :products, dependent: :destroy

  # CALLBACKS

  # VALIDATIONS

  validates :name, presence: true

  # SCOPES

  # CLASS METHODS

  # INSTANCE METHODS

  # ALIAS

  # PRIVATE

  private
  
end
