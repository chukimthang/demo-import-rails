class Backend::BaseController < ApplicationController
  layout 'backend'

  before_action :authenticate_admin!

  check_authorization :unless => :devise_controller?

  def current_ability
    @current_ability ||= AdminAbility.new current_admin
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to admin_root_url, :alert => exception.message
  end
end
