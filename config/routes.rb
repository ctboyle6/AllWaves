Rails.application.routes.draw do
  devise_for :users
  root to: 'dashboards#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :dashboard, only: [:show], :as => :user_root
  resources :preferences
  # /result/spots/:id?preference_id=99
  # result_spot_path(@spot, preference_id: @preference.id)
  namespace :result do
    resources :spots, only: :show
  end
  resources :spots, only: [:index, :show, :new, :create] do
    resources :user_spots, only: [:index, :show, :create, :destroy]
  end
end
