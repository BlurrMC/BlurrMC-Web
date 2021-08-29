Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/kool', as: 'rails_admin'
  devise_for :users , controllers: { sessions: 'sessions', registrations: 'registrations' }
  resource :two_factor_settings, except: [:index, :show]
  
  root to: 'home#index'
  resources :videos
  mount API::Base, at: "/api/"
  resources :relationships
  resources :removerelationships
  resources :blocks
  resources :cs do
    collection do
      get :autocomplete
    end
    member do
      get :following, :followers
    end
    resources :reports
  end
  resources :videos do
    resources :comments do
      resources :commentlikes, only: [:create, :destroy]
      resources :reports
    end
    resources :reports
    resources :likes
  end
  get '/privacy_policy', to: 'terms#privacypolicy'
  get '/terms_of_service', to: 'terms#termsofservice'
  get '/contact', to: 'terms#contact'
  get '/@:id', to: 'cs#show'
  namespace :api do
    namespace :v1 do
      resource :sessions, only: [:create, :destroy]
      resource :two_factor_settings, only: [:create, :destroy] do
        post :verifyotp
      end
      resources :registrations, only: [:update, :create]
      resources :channels
      resources :checkforotp
      resources :reports
      resources :channelsresponds
      resources :apihomefeed
      resources :blocks
      resources :channelvideos
      resources :notifications do
        collection do
          post :mark_as_read
          post :unread_count
        end
      end
      resources :apirandomfeed
      resources :trending
      resources :videos do
        resources :comments do 
          resources :commentlikes
        end
        resources :apilikes
        resources :didyoulikeit
      end
      resources :videoinfo
      resources :search
      resources :apirelationships
      resources :isuservalid
      resources :notificationtokenremoval
      resources :registernotificationtoken
      resources :isuserfollowing
      resources :channelsfollowers do
        member do
          get :followers
        end
      end
      resources :videouploads
      resources :channelsfollowing do
        member do
          get :following
        end
      end

      resources :notification_settings, only: [:index]
      patch :enablefollownotifications, :to => "notification_settings#enablefollownotifications"
      patch :disablefollownotifications, :to => "notification_settings#disablefollownotifications"

      patch :enablecommentnotifications, :to => "notification_settings#enablecommentnotifications"
      patch :disablecommentnotifications, :to => "notification_settings#disablecommentnotifications"

      patch :enablelikecommentnotifications, :to => "notification_settings#enablelikecommentnotifications"
      patch :disablelikecommentnotifications, :to => "notification_settings#disablelikecommentnotifications"

      patch :enablereplynotifications, :to => "notification_settings#enablereplynotifications"
      patch :disablereplynotifications, :to => "notification_settings#disablereplynotifications"

      patch :enablelikedvideonotifications, :to => "notification_settings#enablelikedvideonotifications"
      patch :disablelikedvideonotifications, :to => "notification_settings#disablelikedvideonotifications"
    end
  end
  resources :notifications do
    collection do
      post :mark_as_read
    end
  end
  resources :errors
  %w( 404 422 500 503 ).each do |code|
    get code, :to => "errors#show", :code => code
  end

  resources :notification_settings, only: [:index]

  patch :enablefollownotifications, :to => "notification_settings#enablefollownotifications"
  patch :disablefollownotifications, :to => "notification_settings#disablefollownotifications"

  patch :enablecommentnotifications, :to => "notification_settings#enablecommentnotifications"
  patch :disablecommentnotifications, :to => "notification_settings#disablecommentnotifications"

  patch :enablelikecommentnotifications, :to => "notification_settings#enablelikecommentnotifications"
  patch :disablelikecommentnotifications, :to => "notification_settings#disablelikecommentnotifications"

  patch :enablereplynotifications, :to => "notification_settings#enablereplynotifications"
  patch :disablereplynotifications, :to => "notification_settings#disablereplynotifications"

  patch :enablelikedvideonotifications, :to => "notification_settings#enablelikedvideonotifications"
  patch :disablelikedvideonotifications, :to => "notification_settings#disablelikedvideonotifications"
end
