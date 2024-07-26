Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'posts#index'
  get '/' => 'posts#index'

  get '/users' => 'users#login'
  get '/users/list' => 'users#list'

  get '/users/login' => 'users#login', as: 'login_user'
  get '/users/clear' => 'users#clear'
  post '/users/login' => 'sessions#create'
  post '/users/:id/change_role' => 'users#change_role'

  get '/posts' => 'posts#index'
  get '/posts/:id' => 'posts#show', as: 'post'

  get '/posts/:id/edit' => 'posts#edit', as: 'edit_post'
  patch '/posts/:id' => 'posts#update'
  put '/posts/:id' => 'posts#update'

  delete '/posts/:id' => 'posts#destroy'
  
  resources :users do
    resources :posts
  end
  
  get '/error_role' => 'errors#error_role'
  get '*path', to: 'errors#error_404', via: :all

end
