class DashboardController < ProtectedController

  def index
    case current_user.role
    when User::CLIENT then render_client
    when User::PROVIDER then render_provider
    end
  end

  protected

  def render_client
    @client = current_client
    render :client
  end

  def render_provider
    @provider = current_provider
    render :provider
  end

end
