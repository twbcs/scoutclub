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
    resources :schedules, :musics, :campings
    resources :movies, except: [:destroy]
    resources :members, :user_groups, :boards, except: [:show]
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
      resources :movies, :schedules, :musics
      resources :boards, :members, except: [:show]

      resources :groups do # admin only
        resources :group_forums, except: [:show, :index]
      end
      resources :forum_kinds, except: [:show] do # admin only
        resources :forums
      end
      resources :user_groups, :art_kinds, :doing_kinds, except: [:show] # admin only
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
  resources :movies, :schedules, :articles, :campings, only: [:index, :show]
  resources :members, :boards,  only: [:index]
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
