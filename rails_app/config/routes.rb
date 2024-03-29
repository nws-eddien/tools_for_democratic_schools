Rails.application.routes.draw do

  #namespace :user_manager do
  #resources :groups
  #  resources :users
  # resources :membershiplevels
  # get 'users/:id/pin_generator' => 'users#pin_generator', as: :pin_generator
  # patch 'users/:id/generate_pin' => 'users#generate_pin', as: :generate_pin
  # get 'membershiplevels/:id/edit_users' => 'membershiplevels#edit_users', as: :membershiplevels_edit_users
  # get 'membershiplevels/:id/show_users' => 'membershiplevels#show_users', as: :membershiplevels_show_users
  # patch 'membershiplevels/:id/update_users' => "membershiplevels#update_users", as: :membershiplevels_update_users
  #end

  post "toggle_left_nav_drawer" => "layouts#toggle_left_nav_drawer", as: :toggle_left_nav_drawer

  namespace :user_manager do
    resources :groups do
      resources :membershiplevels, except: [:index, :show]
    end
    resources :users do
      get 'pin_generator' => 'users#pin_generator', as: :pin_generator
      patch 'generate_pin' => 'users#generate_pin', as: :generate_pin
    end
    resources :apps do
      resources :roles
    end
  end

  namespace :media_time do
    resources :media_times
    get 'media_global_setting' => 'media_global_settings#show'
    get 'media_global_setting/edit' => 'media_global_settings#edit'
    patch 'media_global_setting.1' => 'media_global_settings#update'
    post 'logins/toggle' => 'logins#toggle_login', as: :logins_toggle
    get 'logins/login_display' => 'logins#login_display', as: :login_display
  end

  namespace :rulebook do
    resources :decision_making_units
    resources :rule_categories
    resources :rule_types
    resources :rules do
      resources :rule_contents
    end
  end

  resources :rooms

  devise_for :users, controllers: {
    sessions: 'devise_users/sessions'
  }
  root to: 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
