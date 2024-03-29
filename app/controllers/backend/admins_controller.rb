class Backend::AdminsController < Backend::BaseController
  authorize_resource

  before_action :find_admin, only: [:edit, :update, :destroy]

  def index
    @admins = Admin.order(created_at: :desc).page(params[:page]).per(10)
    @breadcrumbs = {t('view.admins.admins') => admin_admins_path, t('view.layout.list') => nil}
  end

  def new
    @breadcrumbs = {t('view.admins.admins') => admin_admins_path, t('view.button.new') => nil}
    @admin = Admin.new
  end

  def create
    @admin = Admin.new admin_params
    if @admin.save
      respond_to do |format|
        format.html {redirect_to admin_admins_path, notice: t('view.messages.created_success', model_name: t('view.admins.model_name'))}
      end
    else
      @breadcrumbs = {t('view.admins.admins') => admin_admins_path, t('view.button.new') => nil}
      render :new
    end
  end

  def edit
    @breadcrumbs = {t('view.admins.admins') => admin_admins_path, t('view.button.edit') => nil}
  end

  def update
    if @admin.update_attributes admin_params
      respond_to do |format|
        format.html {redirect_to admin_admins_path, notice: t('view.messages.updated_success', model_name: t('view.admins.model_name'))}
      end
    else
      @breadcrumbs = {t('view.admins.admins') => admin_admins_path, t('view.button.edit') => nil}
      render :edit
    end
  end

  def destroy
    if @admin.destroy
      flash[:success] = t('view.messages.deleted_success', model_name: t('view.admins.model_name'))
    else
      flash[:danger] = @admin.errors.full_messages
    end

    redirect_to admin_admins_path
  end

  private

  def find_admin
    @admin = Admin.find_by_id params[:id]
    redirect_to admin_admins_path, flash: {danger: t('view.messages.not_found', model_name: t('view.admins.model_name'))} unless @admin
  end

  def admin_params
    if params[:admin][:password].blank?
      params.require(:admin).permit :email
    else
      params.require(:admin).permit :email, :password, :password_confirmation
    end
  end
end
