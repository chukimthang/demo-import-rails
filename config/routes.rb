Rails.application.routes.draw do
  devise_for :admin, path: 'admin', controllers: {
    sessions: 'sessions',
    passwords: 'passwords'
  }

  scope :admin, as: :admin do
    scope module: :backend do
      root 'home#index'
    end
  end

  scope module: :frontend do
    root 'home#index'
  end
end
