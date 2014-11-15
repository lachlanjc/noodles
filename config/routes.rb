Rails.application.routes.draw do

  root 'recipes#index'

  resources :recipes do
    get '/cook' => 'cook#index'
  end

  resources :announcements

  get '/recipes/favorites' => 'recipes#favorites', as: :favorites
  get '/random_recipe' => 'recipes#random_recipe', as: :random_recipe
  get '/recipes/:id/edit/remove_image' => 'recipes#remove_image', as: :remove_image

  get '/s/:id' => 'recipes#share', as: :recipe_share
  get '/s/:id/save' => 'recipes#save_to_noodles', as: :save_to_noodles

  get '/home' => 'recipes#home', as: :home

  get '/help' => 'help#help'
  get '/help/favorites' => 'help#favorites'

  devise_for :users, :controllers => { :registrations => 'registrations' }

  as :user do
    get    'sign_in'  => 'devise/sessions#new',         as: :sign_in
    post   'sign_in'  => 'devise/sessions#create',      as: :update_user_session
    get    'sign_out' => 'devise/sessions#destroy',     as: :sign_out

    get    'sign_up' => 'devise/registrations#new',     as: :sign_up
    post   'sign_up' => 'devise/registrations#create',  as: :add_user
    put    'sign_up' => 'devise/registrations#update',  as: :update_user_registration
    delete 'sign_up' => 'devise/registrations#destroy', as: :destroy_user

    get    'onboarding' => 'devise/registrations#onboarding', as: :onboarding

    get    'settings' => 'devise/registrations#edit',    as: :settings

    get    'forgot_password' => 'devise/passwords#new', as: :forgot_password
    get    'change_password' => 'devise/passwords#edit', as: :change_password
  end

  get '/admin/all_users' => 'analytics#all_users', as: :analytics_users
  get '/admin/user_marketable' => 'analytics#marketable', as: :analytics_marketable
  get '/admin/recipes' => 'analytics#recipes', as: :analytics_recipes

end
