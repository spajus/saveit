Bm::Application.routes.draw do

  match "/privacy" => "static#privacy"
  match "/about" => "static#about"
  match "/eula" => "static#eula"

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, controllers: { omniauth_callbacks: "users/auth" }

  scope "api" do
    match "/bookmarks/filter/:type" => "bookmarks#filter"

    resources :bookmarks
    resources :settings

    resources :tags do
      get    'bookmarks'     => 'tags#list_bookmarks'
    end
  end

  root :to => "home#index"

  match "/bookmarklet" => "home#bookmarklet"
  match "/url-preview" => "home#preview"
  match "/test-snap" => "home#test_snapping"
  match "/opensearch" => "home#opensearch"
  match "/bookmarklet/failover" => "home#bookmarklet_failover"
  match "/zimg/:id" =>"home#zimg"

  mount Jasminerice::Engine => "/specs" unless Rails.env.production?

  # This should go last. It's for the main backbone app
  match "*path" => "home#index"

end
