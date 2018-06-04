Rails.application.routes.draw do

  resources :guests
  resources :units
  resources :reservations

  get '/home', to: 'session#show', as: 'home'
  get '/login', to: 'session#new', as: 'login'
  get '/logout', to: 'session#destroy', as: 'logout'
  get '/auth/:provider/callback', to: 'session#create'
  match '/auth/:provider/callback', to: 'session#create', via: ['get','post']

end
