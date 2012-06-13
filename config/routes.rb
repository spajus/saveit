Bm::Application.routes.draw do

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
  match "/opensearch" => "home#opensearch"
  match "/bookmarklet/failover" => "home#bookmarklet_failover"

  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure" => "sessions#failure"

  match "/signout" => "sessions#destroy", :as => :signout

  mount Jasminerice::Engine => "/specs" unless Rails.env.production?

  # This should go last. It's for the main backbone app
  match "*path" => "home#index"

end
