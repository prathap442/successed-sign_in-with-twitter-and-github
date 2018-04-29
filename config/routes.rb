Rails.application.routes.draw do
  root 'say#index'
  get '/users/auth/twitter',to: "users/omniauth#passthru"
  get '/users/auth/github', to: "users/omniauth#passthru"
  get '/users/auth/twitter/callback',to: "users/omniauth#twitter"
  get '/users/auth/github/callback',to: "users/omniauth#github"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
