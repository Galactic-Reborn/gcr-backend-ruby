Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users
    get 'messages', to: 'messages#message'
    get 'profile', to: 'profile#show'
    put 'profile', to: 'profile#update'

    resources :planets, only: [:index, :show] do
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
