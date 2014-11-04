Rails.application.routes.draw do

  devise_for :users, :controllers => {
  :registrations => "users/registrations",
  :passwords     => "users/passwords",
  :omniauth_callbacks => "users/omniauth_callbacks"
  }

  namespace :dashboard do
    resources :articles do
        post :append, :on => :member
    end
    resources :forums do
      resources :posts, except: [:index]
    end
    resources :posts, except: [:index]
    root 'welcomes#index'

    namespace :admin do  #, :path => "sekret" 改路徑名
      resources :members
      resources :titles
      resources :schedules
      resources :musics
      resources :albums
      resources :boards
      resources :art_types, except: [:show]
      resources :groups do
        resources :group_forums, except: [:show, :index]
      end
      resources :user_groups, except: [:show]
      resources :articles do
          post :append, :on => :member
      end
      resources :forums do
        resources :posts, except: [:index]
      end
      resources :forum_types do
        resources :forums
      end
      resources :doing_types, except: [:show]
      root 'welcomes#index'
    end
  end

  resources :articles,  only: [:index, :show]
  resources :forums,    only: [:index, :show] do
    resources :posts,   only: [:show]
  end
  resources :boards,    only: [:index]
  resources :schedules, only: [:index, :show]
  resources :musics,    only: [:index, :show]
  resources :albums,    only: [:index, :show]
  resources :members,   only: [:index]
  resources :titles,    only: [:index]
  resources :title_ths, only: [:index] # not admin

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
