class HomeController < ApplicationController

  def index
    if user_signed_in?
      case current_user.role
      when User::CLIENT, User::PROVIDER then redirect_to dashboard_path
      when User::ADMIN then render text: 'WAIT ADMIN'
      end
    end
  end

end
