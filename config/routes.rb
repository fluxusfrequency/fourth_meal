OnoBurrito::Application.routes.draw do
  root :to => "restaurants#index"

  get "/log_out" => "sessions#destroy"
  get "/log_in" => "sessions#new", as: "log_in"
  get "/sign_up" => "users#new"

  namespace :superman do
    get "/" => "dashboard#index"
    get "/approval" => "restaurants#index", as: "approval"
    get "/rejected" => "restaurants#rejected", as: "rejected"
    resources :restaurants
    post "/restaurants/approve" => "restaurants#approve", as: "approve"
    post "/restaurants/reject" => "restaurants#reject", as: "reject"
  end

  resources :users
  resources :sessions
  resources :restaurants
  resources :addresses


  scope ":restaurant_slug" do
    resources :contacts
    resources :items, only: [:index, :in_category]
    resources :locations
    resources :orders
    resources :order_items
    get '/transactions/guest' => 'transactions#checkout_as_guest', as: "guest_transaction"
    post '/transactions/guest' => 'transactions#add_guest_address', as: "guest_address"
    resources :transactions, only: [:new, :create, :show]
    get 'menu' => 'items#index', as: :menu
    get '/' => 'items#index', as: :restaurant_root
    get "menu/:category_slug" => "items#in_category", as: "menu_items"

    namespace :admin do
      get "/" => "dashboard#index"
      put "/" => "restaurants#update"
      resources :restaurants
      resources :orders
      resources :items
    end
  end

end
