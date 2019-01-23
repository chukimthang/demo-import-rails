class Backend::AdminsController < Backend::BaseController
  authorize_resource

  before_action :find_admin, only: [:edit, :update, :destroy]

  def index
    @admins = Admin.order(created_at: :desc).page(params[:page]).per(10)
    @breadcrumbs = {'Admins' => admin_admins_path, 'List' => nil}
  end

  def new
    @breadcrumbs = {'Admins' => admin_admins_path, 'New' => nil}
    @admin = Admin.new
  end

  def create
    @admin = Admin.new admin_params
    if @admin.save
      respond_to do |format|
        format.html {redirect_to admin_admins_path, notice: 'Admin was successfully created'}
      end
    else
      @breadcrumbs = {'Admins' => admin_admins_path, 'New' => nil}
      render :new
    end
  end

  def edit
    @breadcrumbs = {'Admins' => admin_admins_path, 'Edit' => nil}
  end

  def update
    if @admin.update_attributes admin_params
      respond_to do |format|
        format.html {redirect_to admin_admins_path, notice: 'Admin was successfully created'}
      end
    else
      @breadcrumbs = {'Admins' => admin_admins_path, 'Edit' => nil}
      render :edit
    end
  end

  def destroy
    if @admin.destroy
      flash[:success] = 'Admin was deleted successfully'
    else
      flash[:danger] = @admin.errors.full_messages
    end

    redirect_to admin_admins_path
  end

  private

  def find_admin
    @admin = Admin.find_by_id params[:id]
    redirect_to admin_admins_path, flash: {danger: 'Admin not found'} unless @admin
  end

  def admin_params
    if params[:admin][:password].blank?
      params.require(:admin).permit :email, :role
    else
      params.require(:admin).permit :email, :password, :password_confirmation, :role
    end
  end
end
