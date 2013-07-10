Watercoolr::Application.routes.draw do
  devise_for :users
  resources :pages
  resources :links
  root to: 'pages#index'
end
