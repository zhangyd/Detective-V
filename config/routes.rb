Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  devise_scope :user do
    get "/auth/:provider/callback" => "callbacks#github"
  end

  authenticated :user do
    root 'repos#index', as: :authenticated_root
  end

  get 'users/auth/github' => "callbacks#github", as: :github
  # resources :issues #Don't need any of the issue routes...
  resources :scans, :only => [:show, :index, :destroy]
  resources :repos, :only => [:index, :show, :new, :create, :destroy]

  get 'issues/publish/:id' => 'issues#publish', as: :publish_issues
  match 'users/settings/' => 'users#settings', as: :user_settings, via: [:get, :post]
  match 'repos/actions' => 'repos#actions', as: :actions, via: [:get, :post]
end
