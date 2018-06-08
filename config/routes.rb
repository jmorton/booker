Rails.application.routes.draw do

  root 'application#pick'

  resource :guests, path: 'guest' do
    resources :reservations, module: 'guests'
    resources :units, module: 'guests'
  end

  resource :owners, path: 'owner' do
    resources :reservations, module: 'owners'
    resources :units, module: 'owners'
  end

  resource  :identity
  resource  :search
  resource  :visitor

  get '/login',   to: 'session#new', as: 'login'
  get '/logout',  to: 'session#destroy', as: 'logout'
  get '/auth/:provider/callback', to: 'session#create'
  match '/auth/:provider/callback', to: 'session#create', via: ['get','post']

end
