Rails.application.routes.draw do

  namespace :public do
    get 'homes/top'
  end
devise_scope :user do
    post 'users/sign_up' => 'public/registrations#create'
    post 'users/guest_sign_in' => 'public/sessions#guest_sign_in'
 end

# 顧客用
# URL /users/sign_in ...
devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
  resources :genres, only: [:index, :create, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :edit, :update, :destroy]
  resources :posts, only: [:index, :show, :edit, :update, :destroy] do
   resources :post_comments, only: [:destroy]
   end
 end

 scope module: "public" do
      root to: "homes#top"
      get "/users/my_page" => "users#show"
      get "/users/:id/confirm" => "users#confirm", as: "confirm"
      patch "/users/:id/withdraw" => "users#withdraw", as: "withdarw"
      get "/genre/:id" => "genres#show"
      resources :users, only: [:index, :show, :edit, :update]
      resources :posts, only: [:index, :show, :edit, :update, :destroy] do
        resources :post_comments, only: [:create, :destroy]
        resource :favorites, only: [:create, :destroy]
      end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
