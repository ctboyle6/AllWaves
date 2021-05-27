Rails.application.routes.draw do
  namespace :result do
    get 'conditions/show'
  end
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :dashboard, only: [:show], :as => :user_root
  resources :preferences
  resources :spots, only: [:index, :show, :create]
  # /result/conditions/:id?preference_id=99
  # result_condition_path(@condition, preference_id: @preference.id)
  namespace :result do
    resources :conditions, only: :show
  end
end
