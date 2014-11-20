Rails.application.routes.draw do

  devise_for :users, :controllers => {
  :registrations => "users/registrations",
  :passwords     => "users/passwords",
  :omniauth_callbacks => "users/omniauth_callbacks"
  }

  namespace :dashboard do #登入後的網頁
    resources :title_ths, only: [:index] # not admin
    resources :members, except: [:show]
    resources :titles, only: [:index, :edit, :update]
    resources :schedules
    resources :musics
    resources :albums do
      resources :photos, only: [:create, :destroy, :show]
    end
    resources :boards, except: [:show]
    resources :articles do
        post :append, :on => :member
    end
    resources :user_groups, except: [:show] #admin only
    resources :forums , only: [:index, :show] do
      resources :posts, except: [:index]
    end
    root 'welcomes#index'

    namespace :admin do  #, :path => "sekret" 改路徑名
      resources :members, except: [:show]
      resources :titles, except: [:show]
      resources :schedules
      resources :musics
      resources :albums do
        resources :photos, only: [:create, :destroy, :show]
      end
      resources :boards, except: [:show]
      resources :articles do
        post :append, :on => :member
      end
      resources :forums do
        resources :posts, except: [:index]
      end
      resources :groups do #admin only
        resources :group_forums, except: [:show, :index]
      end
      resources :user_groups, except: [:show] #admin only

      resources :forum_kinds, except: [:show] do #admin only
        resources :forums
      end
      resources :art_kinds, except: [:show] #admin only
      resources :doing_kinds, except: [:show] #admin only
      resources :title_ths, only: [:index] # not admin

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
  resources :albums,    only: [:index, :show] do
    resources :photos, only: [:show]
  end
  resources :members,   only: [:index]
  resources :titles,    only: [:index]
  resources :title_ths, only: [:index] # not admin

  root 'welcomes#index'

  if ::Rails.env.development? # production 需要改設定
    match '*path', via: :all, to: 'welcomes#error_404'
  end

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
