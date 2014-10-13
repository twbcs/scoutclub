Rails.application.routes.draw do

  devise_for :users, :controllers => {
  :registrations => "users/registrations",
  :passwords     => "users/passwords",
  :omniauth_callbacks => "users/omniauth_callbacks"
  }

  resources :user_groups
  resources :members
  resources :titles
  resources :title_ths
  resources :boards
  resources :forums do
    resources :posts
  end
  resources :forum_types do
    resources :forums
  end
  resources :groups do
    resources :group_forums
  end
  resources :schedule_attends
  resources :schedules
  resources :doing_types
  resources :group_forums
  resources :posts


  root 'members#index'


  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
