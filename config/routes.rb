Rails.application.routes.draw do

  root to: "homes#top"
  get "/about" => "homes#about", as: "about"
  get "/admin"  => "admin/homes#top"
  get "/customers/my_page"  => "public/customers#show"
  get "/customers/unsubscribe" => "public/customers#unsubscribe", as: "unsubscribe"
  patch '/customers/withdraw' => 'public/customers#withdraw', as: "withdraw"
  delete "/cart_items/destroy_all" => "public/cart_items#destroy_all", as: "destroy_all_cart_items"
  get "/orders/complete" => "public/orders#complete"
  post "/orders/confirm" => "public/orders#confirm"

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  scope module: :public do
    resources :items, only: [:index, :show]
    resources :customers, only: [:edit, :update]
    resources :cart_items, only: [:index, :update, :destroy, :create]
    resources :orders, only: [:new, :create, :index, :show]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions",
  }

  namespace :admin do
    resources :genres, only: [:index, :edit, :update, :create, :show]
    resources :items, only: [:index, :edit, :update, :create, :show, :new]
    resources :customers, only: [:index, :show, :edit, :update]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
