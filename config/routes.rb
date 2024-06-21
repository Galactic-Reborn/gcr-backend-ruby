Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users
    get 'messages', to: 'messages#message'
    get 'profile', to: 'profile#show'
    put 'profile', to: 'profile#update'
    post 'universe/solar_system', to: 'universe_fields#solar_system'

    resources :planets, only: [:index, :show, :update] do
      collection do
        get 'home', to: 'planets#home_planet'
      end
      member do
        post :set_as_home
      end
      resources :buildings, only: [:index] do
        collection do
          post  :build
          post  :cancel
          post  :demolish
        end
      end
    end
  end
end
