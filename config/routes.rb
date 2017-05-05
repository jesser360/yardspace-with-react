Rails.application.routes.draw do


  get '/users/:id', to: 'users#show', as: 'user_path'
  get '/signup' => 'users#new'
  get '/users/edit/:id', to: 'users#edit', as: 'edit_user_path'
  patch '/users/update/:id', to: 'users#update', as: 'update_user_path'
  post '/signup' => 'users#create'

  get '/yards/show/:id', to: 'yards#show', as: 'yard_path'
  get '/yards/edit/:id', to: 'yards#edit', as: 'edit_yard_path'
  get '/yards/new', to: 'yards#new', as: 'new_yard_path'
  post '/yards', to: 'yards#create', as: 'create_yard_path'
  delete '/yards/destroy/:id', to: 'yards#destroy', as: 'destroy_yard_path'
  patch 'yards/update/:id', to: 'yards#update', as: 'update_yard_path'
  get 'cities/:city', to: 'yards#cities', as: 'city_path'

  get '/bookings/new', to: 'bookings#new', as: 'new_booking_path'
  post '/bookings', to: 'bookings#create', as: 'create_booking_path'

  post '/comments', to: 'comments#create', as: 'create_comment_path'
  delete '/comments/destroy/:id', to: 'comments#destroy', as: 'destroy_comment_path'

  get '/' => 'pages#home'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
end
