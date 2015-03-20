Rails.application.routes.draw do
  root to: 'posts#index'

  resources :posts, only: [:show, :new, :create, :edit, :update]
end
