Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  namespace :dashboard do # login after page
    resources :titles, only: [:index, :edit, :update] do
      get 'title_ths', on: :collection
    end
    resources :albums do
      resources :photos, only: [:create, :destroy, :show]
    end
    resources :articles, except: [:destroy] do
      post :append, on: :member
      delete 'comment_destroy', on: :member
    end
    resources :forums, only: [:index, :show] do
      resources :posts, except: [:index]
    end
    resources :movies, except: [:destroy]
    resources :members, except: [:show]
    resources :schedules
    resources :musics
    resources :boards, except: [:show]
    resources :user_groups, except: [:show]
    resources :campings
    root 'welcomes#index'

    namespace :admin do  # , :path => "sekret" change path
      resources :titles, except: [:show] do
        get 'title_ths', on: :collection
      end
      resources :albums do
        resources :photos, only: [:create, :destroy, :show]
      end
      resources :articles do
        post :append, on: :member
        delete 'comment_destroy', on: :member
      end
      resources :forums do
        resources :posts, except: [:index]
      end
      resources :movies
      resources :boards, except: [:show]
      resources :members, except: [:show]
      resources :schedules
      resources :musics

      resources :groups do # admin only
        resources :group_forums, except: [:show, :index]
      end
      resources :forum_kinds, except: [:show] do # admin only
        resources :forums
      end
      resources :user_groups, except: [:show] # admin only
      resources :art_kinds, except: [:show] # admin only
      resources :doing_kinds, except: [:show] # admin only
      root 'welcomes#index'
    end
  end

  resources :forums,    only: [:index, :show] do
    resources :posts,   only: [:show]
  end
  resources :albums,    only: [:index, :show] do
    resources :photos, only: [:show]
  end
  resources :titles,    only: [:index] do
    get 'title_ths', on: :collection
  end
  resources :movies, only: [:index, :show]
  resources :members,   only: [:index]
  resources :boards,    only: [:index]
  resources :schedules, only: [:index, :show]
  resources :articles,  only: [:index, :show]
  resources :campings,  only: [:index, :show]
  root 'welcomes#index'

  if ::Rails.env.development? # production need change
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
