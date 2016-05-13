class OrdersController < ProtectedController

  def index
    @orders = current_orders.recent
  end

  def show
    @order = Order.find params[:id]
  end

  protected

  def current_orders
    case current_user.role
    when User::CLIENT then current_client.orders
    when User::PROVIDER then current_provider.orders
    else Order.all
    end
  end

end
