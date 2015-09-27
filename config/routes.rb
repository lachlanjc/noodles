Rails.application.routes.draw do

  root "pages#home"
  get "/home" => "pages#home_forced", as: :home
  get "/styleguide" => "pages#styleguide", as: :styleguide

  resources :recipes do
    get "/cook" => "cook#index"
    get "/notes" => "recipes#notes"
    patch "/update_notes" => "recipes#update_notes"
    get "/pdf" => "recipes#export_pdf", as: :export_pdf
    get "/share" => "recipes#share_this_recipe", as: :share_it
    get "/un_share" => "recipes#un_share", as: :un_share
    get "/remove_image" => "recipes#remove_image", as: :remove_image
  end

  get "/embed/:shared_id" => "recipes#embed_js", as: :embed

  get '/save', to: 'save#save', as: :save

  # Shared recipes
  scope "/s" do
    get "/:shared_id" => "recipes#share", as: :share
    get "/:shared_id/cook" => "cook#share", as: :public_cook
    get "/:shared_id/save" => "recipes#save_to_noodles", as: :save_to_noodles
  end

  # Shared collections
  scope "/c" do
    get "/data/:id" => "collections#share"
    get "/:hash_id" => "collections#share", as: :collection_share
  end

  get '/about', to: 'pages#about', as: :about
  get '/help', to: 'pages#about', as: :help
  get '/docs', to: 'pages#docs', as: :docs
  get '/privacy', to: 'pages#privacy', as: :privacy
  get '/terms', to: 'pages#terms', as: :terms

  resources :announcements
  resources :collections, except: [:new, :edit]

  get "/announcements/unsubscribe/EAY7pdX9/:user_id" => "announcements#unsubscribe"

  devise_for :users, :controllers => { :registrations => "registrations", :sessions => "sessions" }

  as :user do
    get    "login"  => "devise/sessions#new",           as: :sign_in
    post   "login"  => "devise/sessions#create",        as: :update_user_session
    get    "logout"  => "devise/sessions#destroy",      as: :sign_out

    get    "signup" => "devise/registrations#new",      as: :sign_up
    post   "signup" => "devise/registrations#create",   as: :add_user
    put    "signup" => "devise/registrations#update",   as: :update_user_registration
    delete "signup" => "devise/registrations#destroy", as: :destroy_user

    get    "onboarding" => "devise/registrations#onboarding", as: :onboarding

    get    "settings" => "devise/registrations#edit",    as: :settings

    get    "forgot_password" => "devise/passwords#new", as: :forgot_password
    get    "change_password" => "devise/passwords#edit", as: :change_password
  end

  # Admin stuff
  scope "/admin" do
    get "/dashboard" => "analytics#dashboard", as: :analytics_dash
    get "/all_users" => "analytics#all_users", as: :analytics_users
    get "/collections" => "analytics#collections", as: :analytics_collections
    get "/performance" => "analytics#performance", as: :analytics_performance
    get "/shared_recipes" => "analytics#shared_recipes", as: :analytics_recipes
  end

end
