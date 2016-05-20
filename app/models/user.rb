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

class User < ApplicationRecord

  # CONFIG

  ROLES = [CLIENT = 'client', PROVIDER = 'provider', ADMIN = 'admin']

  # Include default devise modules. Others available are:
  # :trackable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :client, required: false
  belongs_to :provider, required: false

  # CALLBACKS

  after_initialize :set_role

  # VALIDATIONS

  validates :role, presence: true, inclusion: { in: ROLES }
  validates :client, presence: true, if: proc { |user| user.is_role?(CLIENT) }
  validates :provider, presence: true, if: proc { |user| user.is_role? CLIENT, PROVIDER }
  validate :provider_not_be_a_client
  validate :admin_not_be_a_client
  validate :admin_not_be_a_provider

  # SCOPES

  default_scope -> { order :created_at }

  # CLASS METHODS

  # INSTANCE METHODS

  def is_role?(*roles)
    roles.include? role
  end

  # ALIAS

  # PROTECTED

  protected

  def set_role
    self.role ||= CLIENT
  end

  def provider_not_be_a_client
    errors.add(:client_id, "is not allowed to be a client") if is_role?(PROVIDER) && client.present?
  end

  def admin_not_be_a_client
    errors.add(:client_id, "is not allowed to be a client") if is_role?(ADMIN) && client.present?
  end

  def admin_not_be_a_provider
    errors.add(:provider_id, "is not allowed to be a provider") if is_role?(ADMIN) && provider.present?
  end

end
