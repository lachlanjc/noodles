Rails.application.routes.draw do

  root 'pages#welcome'

  get '/home' => 'pages#welcome'

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

end
