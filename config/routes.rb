Rails.application.routes.draw do
  devise_for :users
  get '/user' => "dashboards#show", :as => :user_root
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :dashboard, only: [:show]
  resources :preferences
  resources :spots, only: [:index, :show, :create]
end
