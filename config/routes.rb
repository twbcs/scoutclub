Rails.application.routes.draw do

  get 'title_ths/index'

  devise_for :users, :controllers => {
  :registrations => "users/registrations",
  :passwords     => "users/passwords",
  :omniauth_callbacks => "users/omniauth_callbacks"
  }

  resources :user_groups, except: [:show]
  resources :members
  resources :titles
  resources :title_ths, only: [:index]
  resources :boards
  resources :forums do
    resources :posts, except: [:index]
  end
  resources :forum_types do
    resources :forums
  end
  resources :groups do
    resources :group_forums, except: [:show, :index]
  end
  resources :schedule_attends
  resources :schedules
  resources :doing_types, except: [:show]
  resources :group_forums, except: [:show, :index]
  resources :posts, except: [:index]


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
