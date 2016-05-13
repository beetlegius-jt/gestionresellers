class DashboardController < ProtectedController

  def index
    render_client   and return if current_user.is_role? User::CLIENT
    render_provider and return if current_user.is_role? User::PROVIDER
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
