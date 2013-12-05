OnoBurrito::Application.routes.draw do
  get "/log_out" => "sessions#destroy"
  get "/log_in" => "sessions#new", as: "log_in"
  get "/sign_up" => "users#new"

  resources :users
  resources :sessions
  resources :restaurants
  root :to => "restaurants#index"


  scope ":restaurant" do
    resources :contacts
    resources :items do
      :item_categories
    end
    resources :locations
    resources :orders
    resources :order_items
    resources :transactions, only: [:new, :create, :show]
    resources :admin_orders
    resources :admin_items
    get 'menu' => 'items#index', as: :menu
    get '/' => 'items#index', as: :restaurant_root
    get "menu/:category_slug" => "items#in_category", as: "menu_items"
    get "/admin" => "admin#index"

  end


end
