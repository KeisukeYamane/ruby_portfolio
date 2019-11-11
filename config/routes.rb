Rails.application.routes.draw do
  root 'homes#top'
  get 'top' => 'homes#top'
  get 'about' => 'homes#about'
  # get 'postall' => 'homes#all'
  get 'posts/new' => 'posts#new'
  post 'posts/create' => 'posts#create'
  get 'posts/:id/edit' => 'posts#edit', as: :edit_post
  patch 'posts/:id' => 'posts#update', as: :post
  delete 'posts/:id/destroy' => 'posts#destroy', as: :destroy_post
  get 'posts/:id' => 'posts#show', as: :posts
  get 'posts/:page/index' => 'posts#index', as: :posts_page_index
  get 'login' => 'users#login_page'
  post 'login' => 'users#login'
  post 'logout' => 'users#logout'

  # get 'admin/users/index' => 'admin/users#index'
  # get 'admin/users/:id/edit' => 'admin/users#edit', as: :admin_edit_post
  # patch 'admin/users/:id' => 'admin/users#update', as: :admin_post
  # post 'admin/users/:id/destroy' => 'admin/users#destroy', as: :admin_destroy_post
  get 'notice' => 'admin/users#index'

  resources :posts do
    resource :favorites, only: [:destroy, :create]
  end

  resources :users
end
