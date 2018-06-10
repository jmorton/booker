Rails.application.routes.draw do

  root 'application#pick'

  resource :guest do
    resources :reservations, module: 'guests'
    resources :units, module: 'guests', only: ['index', 'show']
  end

  resource :owner do
    resources :reservations, module: 'owners', only: ['index', 'show']
    resources :units, module: 'owners'
  end

  resource  :search,   only: 'show'
  resource  :identity, only: 'show'
  resource  :visitor,  only: 'show'

  get '/login',   to: 'session#new', as: 'login'
  get '/logout',  to: 'session#destroy', as: 'logout'
  get '/auth/:provider/callback', to: 'session#create'
  match '/auth/:provider/callback', to: 'session#create', via: ['get', 'post']

end
