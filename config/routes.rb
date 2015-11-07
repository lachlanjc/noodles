Rails.application.routes.draw do

  root 'pages#home'
  get '/home', to: 'pages#home_forced', as: :home
  get '/styleguide', to: 'pages#styleguide', as: :styleguide

  resources :recipes do
    get '/cook', to: 'cook#index'
    get '/notes', to: 'recipes#notes'
    patch '/update_notes', to: 'recipes#update_notes'
    get '/pdf', to: 'recipes#export_pdf', as: :export_pdf
    get '/share', to: 'recipes#share_this_recipe', as: :share_it
    get '/un_share', to: 'recipes#un_share', as: :un_share
    get '/remove_image', to: 'recipes#remove_image', as: :remove_image
  end

  get '/embed/:shared_id', to: 'recipes#embed_js', as: :embed

  get '/save', to: 'save#save', as: :save

  # Shared recipes
  scope '/s' do
    get '/:shared_id', to: 'recipes#share', as: :share
    get '/:shared_id/cook', to: 'cook#share', as: :public_cook
    get '/:shared_id/save', to: 'recipes#save_to_noodles', as: :save_to_noodles
  end

  # Shared collections
  scope '/c' do
    get '/data/:id', to: 'collections#share'
    get '/:shared_id', to: 'collections#share', as: :collection_share
  end

  scope '/explore' do
    get '/', to: 'explore#index', as: :explore
    get '/results', to: 'explore#results'
    get '/preview', to: 'explore#preview'
  end

  get '/about', to: 'pages#about', as: :about
  get '/help', to: 'pages#about', as: :help
  get '/docs', to: 'pages#docs', as: :docs
  get '/privacy', to: 'pages#privacy', as: :privacy
  get '/terms', to: 'pages#terms', as: :terms

  get '/blog', to: 'announcements#index'
  resources :announcements
  resources :collections, except: [:new, :edit]

  get '/announcements/unsubscribe/:code/:user_id', to: 'announcements#unsubscribe', as: :unsubscribe

  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  as :user do
    get  'login' , to: 'devise/sessions#new',           as: :sign_in
    post 'login' , to: 'devise/sessions#create',        as: :update_user_session
    get  'logout' , to: 'devise/sessions#destroy',      as: :sign_out

    get    'signup', to: 'devise/registrations#new',      as: :sign_up
    post   'signup', to: 'devise/registrations#create',   as: :add_user
    put    'signup', to: 'devise/registrations#update',   as: :update_user_registration
    delete 'signup', to: 'devise/registrations#destroy', as: :destroy_user

    get 'onboarding', to: 'devise/registrations#onboarding', as: :onboarding

    get 'settings', to: 'devise/registrations#edit',    as: :settings

    get 'forgot_password', to: 'devise/passwords#new', as: :forgot_password
    get 'change_password', to: 'devise/passwords#edit', as: :change_password
  end

  scope '/admin' do
    get '/dashboard', to: 'analytics#dashboard', as: :analytics_dash
    get '/all_users', to: 'analytics#all_users', as: :analytics_users
    get '/collections', to: 'analytics#collections', as: :analytics_collections
    get '/performance', to: 'analytics#performance', as: :analytics_performance
    get '/shared_recipes', to: 'analytics#shared_recipes', as: :analytics_recipes
  end
end
