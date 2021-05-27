Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :dashboard, only: [:show], :as => :user_root
  resources :preferences
  resources :spots, only: [:index, :show, :new, :create]
end
