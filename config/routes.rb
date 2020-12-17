Rails.application.routes.draw do
  root 'pages#home'
  get '/home', to: 'pages#home', as: :home
  get '/ph', to: 'pages#home'
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
  end

  scope 'embed' do
    get '/', to: 'pages#embed_demo', as: :embed_demo
    get '/:shared_id', to: 'recipes#embed_js', as: :embed
  end

  resources :collections, except: %i[new edit]
  get '/c/:shared_id', to: 'collections#share', as: :coll_share

  get '/save', to: 'save#save', as: :save

  scope '/explore' do
    get '/', to: 'explore#index', as: :explore
    get '/results', to: 'explore#results'
    get '/preview', to: 'explore#preview'
  end

  resources :groceries, except: %i[show edit] do
    collection do
      get '/past', to: 'groceries#past', as: :past
    end
  end
  post '/groceries/sms', to: 'sms#groceries'

  get '/privacy', to: 'pages#privacy', as: :privacy
  get '/terms', to: 'pages#terms', as: :terms
  get '/contact', to: 'pages#help', as: :contact
  get '/help', to: 'pages#help', as: :help

  resources :subscriptions, only: %i[index create destroy]

  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  as :user do
    get  'login',     to: 'sessions#new',                 as: :log_in
    get  'sign_in',   to: 'sessions#new',                 as: :sign_in
    post 'login',     to: 'devise/sessions#create',       as: :update_user_session
    get  'sign_out',  to: 'devise/sessions#destroy',      as: :sign_out

    get    'sign_up', to: 'devise/registrations#new',     as: :sign_up
    post   'sign_up', to: 'devise/registrations#create',  as: :add_user
    put    'sign_up', to: 'devise/registrations#update',  as: :update_user_registration
    delete 'goodbye', to: 'devise/registrations#destroy', as: :destroy_user

    get 'my/settings', to: 'devise/registrations#edit',   as: :settings

    get 'forgot_password', to: 'devise/passwords#new',    as: :forgot_password
    get 'change_password', to: 'devise/passwords#edit',   as: :change_password
  end
  get '.well-known/change-password', to: redirect('/my/settings')

  scope '/admin' do
    get '/dashboard', to: 'analytics#dashboard', as: :analytics_dash
    get '/all_users', to: 'analytics#all_users', as: :analytics_users
  end
end
