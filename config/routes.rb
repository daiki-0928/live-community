Rails.application.routes.draw do
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
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
