SoundcloudTest::Application.routes.draw do
  resources :events 

  devise_for :users

  root to: "events#index"
  
  devise_scope :user do
    get 'register', to: 'devise/registrations#new', as: :register
    get 'login', to: 'devise/sessions#new', as: :login
    get 'logout', to: 'devise/sessions#destroy', as: :logout
    #
    get ':profile_name', to: 'devise/registrations#edit', as: :edit_user
  end
end
