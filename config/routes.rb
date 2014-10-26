Rails.application.routes.draw do

  root 'recipes#index'

  resources :recipes do
    get '/cook' => 'cook#index'
  end

  get '/s/:id' => 'recipes#share', as: :recipe_share
  get '/s/:id/save' => 'recipes#save_to_noodles', as: :save_to_noodles

  get '/recipes/favorites' => 'recipes#favorites', as: :favorites

  get '/home' => 'recipes#home', as: :home

  get '/help' => 'help#help'
  get '/help/favorites' => 'help#favorites'

  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions"}, skip: [:sessions, :registrations]

  as :user do
    get    "sign_in"  => "devise/sessions#new",         as: :create_user_session
    post   "sign_in"  => "devise/sessions#create",      as: :user_session
    get    "sign_out" => "devise/sessions#destroy",     as: :destroy_user_session

    get    "sign_up" => "devise/registrations#new",     as: :add_user
    post   "sign_up" => "devise/registrations#create",  as: :user_registration
    put    "sign_up" => "devise/registrations#update",  as: :update_user_registration
    delete "sign_up" => "devise/registrations#destroy", as: :destroy_user
    get    "account" => "devise/registrations#edit",    as: :edit_user_registration
  end

  get '/admin/all_users' => 'analytics#all_users', as: :analytics_users
  get '/admin/user_marketable' => 'analytics#marketable', as: :analytics_marketable
  get '/admin/recipes' => 'analytics#recipes', as: :analytics_recipes

end
