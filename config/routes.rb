Rails.application.routes.draw do
  root "users#index"

  resource :users, only: [:index, :show] do
    resource :posts, only: [:show]
  end
end
