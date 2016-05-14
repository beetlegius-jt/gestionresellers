class ProductsController < ProtectedController

  def index
    @products = current_provider.products.search(params[:search]).page(params[:page]).decorate
  end

  def show
    @product = Product.find(params[:id]).decorate
  end
end
