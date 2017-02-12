Rails.application.routes.draw do
  root 'pages#home'
  get '/home', to: 'pages#home', as: :home
  get '/styleguide', to: 'pages#styleguide', as: :styleguide

  resources :recipes do
    member do
      post '/', to: 'recipes#update'
      get '/cook', to: 'cook#index', as: :cook
      post '/cook', to: 'cook#record_cook'
      get '/collections', to: 'recipes#collections'
      get '/pdf', to: 'recipes#export_pdf', as: :export_pdf
      get '/remove_image', to: 'recipes#remove_image', as: :remove_image
    end
  end

  scope '/s/:shared_id' do
    get '/', to: 'recipes#share', as: :share
    get '/cook', to: 'cook#index', as: :public_cook
    get '/save', to: 'recipes#save_to_noodles', as: :save_to_noodles
  end

  scope 'embed' do
    get '/', to: 'pages#embed_demo', as: :embed_demo
    get '/:shared_id', to: 'recipes#embed_js', as: :embed
  end

  resources :collections, except: [:new, :edit]
  get '/c/:shared_id', to: 'collections#share', as: :coll_share

  get '/save', to: 'save#save', as: :save

  scope '/explore' do
    get '/', to: 'explore#index', as: :explore
    get '/results', to: 'explore#results'
    get '/preview', to: 'explore#preview'
  end

  get '/contact', to: 'pages#help', as: :contact
  get '/help', to: 'pages#help', as: :help
  get '/privacy', to: 'pages#privacy', as: :privacy
  get '/terms', to: 'pages#terms', as: :terms

  get '/blog', to: 'announcements#index'
  get '/announcements/unsubscribe/:code/:user_id', to: 'announcements#unsubscribe', as: :unsubscribe

  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  as :user do
    get  'login',     to: 'sessions#new',                 as: :log_in
    get  'signin',    to: 'sessions#new',                 as: :sign_in
    post 'login',     to: 'devise/sessions#create',       as: :update_user_session
    get  'logout',    to: 'devise/sessions#destroy',      as: :sign_out

    get    'signup',  to: 'devise/registrations#new',     as: :sign_up
    post   'signup',  to: 'devise/registrations#create',  as: :add_user
    put    'signup',  to: 'devise/registrations#update',  as: :update_user_registration
    delete 'signup',  to: 'devise/registrations#destroy', as: :destroy_user

    get 'subscribe', to: 'registrations#subscribe', as: :subscribe

    get 'settings', to: 'devise/registrations#edit',     as: :settings

    get 'forgot_password', to: 'devise/passwords#new',   as: :forgot_password
    get 'change_password', to: 'devise/passwords#edit',  as: :change_password
  end

  scope '/admin' do
    get '/dashboard', to: 'analytics#dashboard', as: :analytics_dash
    get '/all_users', to: 'analytics#all_users', as: :analytics_users
    get '/performance', to: 'analytics#performance', as: :analytics_performance
  end
end
