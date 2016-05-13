class ProductsController < ProtectedController

  def index
    @products = ProductDecorator.decorate_collection(Product.all)
  end

  def show
    @product = Product.find(params[:id]).decorate
  end
end
