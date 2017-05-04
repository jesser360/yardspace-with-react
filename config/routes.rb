Rails.application.routes.draw do


  get '/users/:id', to: 'users#show', as: 'user_path'
  get '/users/edit/:id', to: 'users#edit', as: 'edit_user_path'
  patch 'users/update/:id', to: 'users#update', as: 'update_user_path'

  get '/yards/new', to: 'yards#new', as: 'new_yard_path'
  post 'yards', to: 'yards#create', as: 'create_yard_path'

  get '/' => 'pages#home'
  get '/signup' => 'users#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  post '/signup' => 'users#create'
end
