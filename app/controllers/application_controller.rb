class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!
  protect_from_forgery with: :exception, prepend: true

  # user_signed_in?
  # current_user
  # user_session

  def index
    if current_provider && current_client
      redirect_to dashboard_path
    else
      render text: 'WAIT ADMIN!'
    end
  end

  def current_provider
    current_user.provider if user_signed_in?
  end

  def current_client
    current_user.client if user_signed_in?
  end

end
