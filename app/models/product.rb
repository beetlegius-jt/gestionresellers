class Product < ApplicationRecord

  # CONFIG

  belongs_to :provider

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
