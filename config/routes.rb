Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  namespace :admin do
    root "items#index"

    resources :items do
      # TODO photos uploading
      resources :photos, except: [:show]

      resources :item_specs, except: [:show]
    end

    resources :categories, only: [:new, :create, :show, :index]
    resources :users, only: [:index, :show]
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
      # TODO 重構整理
      # 分類API
      resources :categories, only: [:index, :show]

      # 商品API
      resources :items, only: [:index, :show]

      # 用戶API
      resources :users, only: [:create, :show, :update]

      # 訂單API
      resources :orders, only: [:create, :show, :index] do
        # 給 uid 回傳 orders[order1 , order2, ...]
        collection do
          get "/user_owned_orders/:uid" => "orders#user_owned_orders"
        end
      end

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