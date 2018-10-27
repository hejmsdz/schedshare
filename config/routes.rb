Rails.application.routes.draw do
  resources :users, only: [] do
    resource :token, only: :create
  end
  resources :binaries, only: :index
end
