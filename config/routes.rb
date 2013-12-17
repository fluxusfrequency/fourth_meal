OnoBurrito::Application.routes.draw do
  root :to => "locations#index"

  get "/log_out" => "sessions#destroy"
  get "/log_in" => "sessions#new", as: "log_in"
  get "/sign_up" => "users#new"


  resources :locations, only: [ :index, :show ]
  resources :users, except: [ :index, :destroy ]
  resources :sessions, only: [ :new, :create, :checkout_as_guest, :destroy ]
  resources :restaurants, except: [ :index, :show, :update, :destroy ]
  resources :addresses

  namespace :superman do
    resource :dashboard, only: [ :index ]
    resources :restaurants, only: [ :index, :destroy, :rejected, :approve, :reject ]

    get "/" => "dashboard#index"
    get "/approval" => "restaurants#index", as: "approval"
    get "/inactive" => "restaurants#inactive", as: "inactive"
    get "/rejected" => "restaurants#rejected", as: "rejected"
    post "/restaurants/approve" => "restaurants#approve", as: "approve"
    post "/restaurants/reject" => "restaurants#reject", as: "reject"
  end

  scope ":restaurant_slug" do
    resources :items, only: [ :index, :in_category ]
    resources :locations, only: [ :index, :show ]
    resources :orders, except: [ :edit ]
    resources :order_items, only: [ :destroy ]
    get '/transactions/guest' => 'transactions#checkout_as_guest', as: "guest_transaction"
    post '/transactions/guest' => 'transactions#add_guest_address', as: "guest_address"
    resources :transactions, except: [ :update, :destroy ]
    
    get '/' => 'items#index', as: :restaurant_root
    get 'menu' => 'items#index', as: :menu
    get "menu/:category_slug" => "items#in_category", as: "menu_items"

    namespace :admin do
      resource :dashboard, only: [ :index ]
      get "/" => "dashboard#index"
      put "/" => "restaurants#update"
      resources :restaurants, only: [ :show, :update, :destroy ]
      resources :orders, only: [ :index, :show, :destroy ]
      resources :items
    end
  end

end
