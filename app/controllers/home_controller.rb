class HomeController < ProtectedController

  def index
    if current_user.is_role?(User::CLIENT, User::PROVIDER)
      redirect_to dashboard_path
    else
      render text: 'WAIT ADMIN!'
    end
  end
  
end
