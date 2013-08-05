Watercoolr::Application.routes.draw do
  devise_for :users
  resources :pages
  resources :links
  resources :comments
  resources :votes

  get 'search' => 'search#index'

  root to: 'pages#index'
end
