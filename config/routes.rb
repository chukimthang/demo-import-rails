Rails.application.routes.draw do
  devise_for :admin, path: 'admin', controllers: {
    sessions: 'backend/sessions',
    passwords: 'backend/passwords'
  }

  scope :admin, as: :admin do
    scope module: :backend do
      root 'home#index'
      resources :admins, except: :show
    end
  end

  scope module: :frontend do
    root 'home#index'
  end
end
