Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'recognition#face'

  namespace :api, default: {format: :json} do
    namespace :v1 do
      resources :users, only: :create do
        put :update, on: :collection
        post :recognition, on: :collection
      end
      resources :sessions, only: :create
    end
  end

end
