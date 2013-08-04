Watercoolr::Application.routes.draw do
  devise_for :users
  resources :pages
  resources :links
  resources :comments
  resources :votes
  root to: 'pages#index'
end
