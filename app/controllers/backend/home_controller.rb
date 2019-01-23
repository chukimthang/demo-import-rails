class Backend::HomeController < Backend::BaseController
  skip_authorization_check only: :index

  def index
    @breadcrumbs = {}
  end
end
