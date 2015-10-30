Rails.application.routes.draw do
  resources :recipes
  resources :likes

  root   'pages#home'
  get    '/home',             to: 'pages#home'

end
