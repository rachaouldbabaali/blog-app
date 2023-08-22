Rails.application.routes.draw do
  root "users#index"

  resource :users
  resource :users, only: [:index, :show]
end
