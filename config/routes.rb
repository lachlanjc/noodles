Rails.application.routes.draw do

  root 'recipes#index'

  resources :recipes do
    get '/cook' => 'cook#index'
    get '/remove_image' => 'recipes#remove_image', as: :remove_image
  end

  resources :announcements

  get '/recipes/favorites' => 'recipes#favorites', as: :favorites
  get '/random_recipe' => 'recipes#random_recipe', as: :random_recipe

  # Shared recipes
  scope '/s' do
    get '/:id' => 'recipes#share', as: :recipe_share
    get '/:id/save' => 'recipes#save_to_noodles', as: :save_to_noodles
  end

  get '/help' => 'help#help'
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
