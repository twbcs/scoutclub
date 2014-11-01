Rails.application.routes.draw do

  get 'welcomes/index'

  devise_for :users, :controllers => {
  :registrations => "users/registrations",
  :passwords     => "users/passwords",
  :omniauth_callbacks => "users/omniauth_callbacks"
  }
  post 'articles/append'
  resources :articles do
    resources :comments, except: [:show, :index]
  end
  resources :comments, except: [:show, :index]
  resources :art_types, except: [:show]
  resources :user_groups, except: [:show]
  resources :members
  resources :titles
  resources :title_ths, only: [:index]
  resources :boards
  resources :forums do
    resources :posts, except: [:index]
  end
  resources :posts, except: [:index]
  resources :forum_types do
    resources :forums
  end
  resources :groups do
    resources :group_forums, except: [:show, :index]
  end
  resources :group_forums, except: [:show, :index]
  resources :schedule_attends
  resources :schedules
  resources :doing_types, except: [:show]

  root 'welcomes#index'

  #if ::Rails.env.production?
  #  match '*path', via: :all, to: 'welcomes#error_404'
  #end


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
