Nastachku::Application.routes.draw do

  match "/404", :to => "web/errors#not_found"
  match "/500", :to => "web/errors#internal_server_error"

  root to: "web/welcome#index"

  mount Ckeditor::Engine => '/ckeditor'

  # omniauth-facebook, omniauth-twitter
  get '/auth/:action/callback' => 'web/social_networks'
  get '/auth/:action/failure' => 'web/social_networks#failure'

  namespace :api do
    resources :companies
    resources :cities

    resources :lectures do
      scope module: :lectures do
        resources :lecture_votings, only: [:create]
        resources :listener_votings, only: [:create]
      end
    end
  end

  scope :module => :web do
    resources :users, only: [:new, :create, :index]
    resources :lectures, only: [ :index ]
    resources :pages, only: [:show]
    resources :news, only: [:index]
    resources :user_lectures, only: [:index]
    resources :lectors, only: [:index]
    resources :user_lectures, only: [:index]
    resource :remind_password, only: [:new, :create]
    resource :session, only: [:new, :create, :destroy]
    resource :schedule, only: [:show]

    resource :user, only: [] do
      get :activate
    end

    resource :account, only: [:edit, :update] do
      scope :module => :account do
        resource :password, only: [:edit, :update]
        resource :social_networks, :only => [] do
          #FIXME по REST тут должен быть put. Решить проблему вызова экшена из другого контроллера
          get :link_twitter
          put :unlink_twitter
        end

        resources :lectures, only: [ :new, :create, :update ]
        resources :orders, only: [:update] do
          put :pay, :on => :member

          collection do
            post :approve
            post :cancel
            post :decline
          end
        end
        resources :afterparty_orders, only: [:new, :create]
        resources :shirt_orders, only: [:new, :create]
      end
    end

    resource :social_networks, :only => [] do 
      get :authorization, :on => :member
    end

    namespace :admin do
      resources :lectures
      resources :pages
      resources :news
      resources :users
      resources :audits, only: [:index]
      resources :topics
      resources :user_events do
        put :change_state
      end

      resources :events
      resources :workshops
      resources :halls
      resources :event_breaks
      resources :orders, only: [:index]

      root to: "welcome#index"
    end
  end

end
