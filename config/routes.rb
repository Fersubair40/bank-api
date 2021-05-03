Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :users, only: [:create, :index, :destroy, :show]
      resources :authenticate, only: [:create]
      resources :accounts, only: [:create, :show] do
        member do
          post :deposit
          post :withdraw
          post :transfer
        end
      end
    end
  end
end
