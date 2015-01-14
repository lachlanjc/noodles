Rails.application.routes.draw do

  root 'pages#home'
  get '/home' => 'pages#home_forced', as: :home

  resources :recipes do
    get '/cook' => 'cook#index'
    get '/share' => 'recipes#share_this_recipe', as: :share_it
    get '/un_share' => 'recipes#un_share', as: :un_share
    get '/remove_image' => 'recipes#remove_image', as: :remove_image
  end

  get '/favorites' => 'recipes#favorites', as: :favorites
  get '/random' => 'recipes#random', as: :random_recipe
  get '/import' => 'recipes#scrape', as: :import

  # Shared recipes
  scope '/s' do
    get '/:shared_id' => 'recipes#share', as: :share
    get '/:shared_id/save' => 'recipes#save_to_noodles', as: :save_to_noodles
  end

  get '/about' => 'pages#about', as: :about
  get '/help' => 'pages#about', as: :help

  resources :announcements
  get '/announcements/unsubscribe/EAY7pdX9/:user_id' => 'announcements#unsubscribe'

  devise_for :users, :controllers => { :registrations => 'registrations' }

  as :user do
    get    'login'  => 'devise/sessions#new',           as: :sign_in
    post   'login'  => 'devise/sessions#create',        as: :update_user_session
    get    'logout'  => 'devise/sessions#destroy',      as: :sign_out

    get    'signup' => 'devise/registrations#new',      as: :sign_up
    post   'signup' => 'devise/registrations#create',   as: :add_user
    put    'signup' => 'devise/registrations#update',   as: :update_user_registration
    delete 'signup' => 'devise/registrations#destroy', as: :destroy_user

    get    'onboarding' => 'devise/registrations#onboarding', as: :onboarding

    get    'settings' => 'devise/registrations#edit',    as: :settings

    get    'forgot_password' => 'devise/passwords#new', as: :forgot_password
    get    'change_password' => 'devise/passwords#edit', as: :change_password
  end

  # Admin stuff
  scope '/admin' do
    get '/dashboard' => 'analytics#dashboard', as: :analytics_dash
    get '/all_users' => 'analytics#all_users', as: :analytics_users
    get '/user_marketable' => 'analytics#marketable', as: :analytics_marketable
    get '/performance' => 'analytics#performance', as: :analytics_performance
    get '/shared_recipes' => 'analytics#shared_recipes', as: :analytics_recipes
  end

end
