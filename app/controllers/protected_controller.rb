class ProtectedController < ApplicationController
  before_action :authenticate_user!

  def current_provider
    current_user.provider
  end

  def current_client
    current_user.client
  end

end
