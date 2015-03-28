Rails.application.routes.draw do
  devise_for :users do
    resources :posts do
      resources :comments, only: [:create, :destroy]
    end
  end
  root to: 'posts#index'

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
end
