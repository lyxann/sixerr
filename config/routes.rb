Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  root 'pages#home'

  devise_for :users,
             :path => '',
             :path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile'},
             :controllers => {:omniauth_callbacks => 'omniauth_callbacks',
                              :registrations => 'registrations'}

  resources :users, only: [:show]
  resources :services

  resources :services do
    resources :orders, only: [:create]
  end

  resources :services do
    resources :reviews, only: [:create, :destroy]
  end

  resources :charges
  resources :orders, only: [:show]

  get '/user_orders'=> 'orders#user_orders'
  get '/user_sales'=> 'orders#user_sales'

  get '/search', to: 'search#search'
end
