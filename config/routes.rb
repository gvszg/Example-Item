Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  
  namespace :admin do
    root "items#index"
    resources :items do
      resources :photos, except: [:show]
    end    
    resources :categories, only: [:new, :create, :show, :index]
    resources :users, only: [:index, :show] do
      collection do
        # TODO
        # 外界POST request
        post "import_user", to: "users#import_user"
      end      
    end
    get "users/show_uid/:uid", to: "users#show_uid", as: "uid_user"
    resources :counties, only: [:index, :show] do
      resources :towns, only: [:index, :show] do
        resources :roads, only: [:index, :show] do
          resources :stores, only: [:index, :show]
        end
      end
    end
    resources :orders, only: [:index, :show] do
      member do
        post "item_shipping"
        post "item_shipped"
        post "order_cancelled"
      end
    end
  end

  namespace :api do
    namespace :v1 do
      # TODO
      # 用戶API
      resources :users, only: [:create, :show]

      # 訂單API
      resources :orders, only: [:create]

      # 超商API
      resources :counties, only: [:index, :show] do
        resources :towns, only: [:index, :show] do
          resources :roads, only: [:index, :show] do
            resources :stores, only: [:index, :show]
          end
        end
      end
    end
  end
end