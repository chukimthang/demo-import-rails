class Backend::ProductsController < Backend::BaseController
  authorize_resource

  before_action :find_product, only: :destroy

  def index
    @products = Product.includes(:category).order(created_at: :desc).page(params[:page]).per(10)
    @breadcrumbs = {'Product' => admin_products_path, 'List' => nil}
  end

  def destroy
    if @product.destroy
      flash[:success] = t('view.messages.deleted_success', model_name: 'Product')
    else
      flash[:danger] = @product.errors.full_messages
    end

    redirect_to admin_products_path
  end

  def show_import
    @breadcrumbs = {'Product' => admin_products_path, 'Show' => nil}
  end

  def import
    @list_error = Product.import(params[:file])
    respond_to do |format|
      format.js
    end
  end

  private

  def find_product
    @product = Product.find_by_id params[:id]
    redirect_to admin_products_path, flash: {danger: t('view.messages.not_found', model_name: 'Product')} unless @product
  end
end
