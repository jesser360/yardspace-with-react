Rails.application.routes.draw do


  get '/users/:id', to: 'users#show', as: 'user_path'
  get '/users/edit/:id', to: 'users#edit', as: 'edit_user_path'

  get '/' => 'pages#home'
  get '/signup' => 'users#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  post '/signup' => 'users#create'
end
