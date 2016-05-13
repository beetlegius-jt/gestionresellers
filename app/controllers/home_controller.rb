class HomeController < ProtectedController

  def index
    case current_user.role
    when User::CLIENT, User::PROVIDER then redirect_to dashboard_path
    when User::ADMIN then render text: 'WAIT ADMIN'
    end
  end

end
