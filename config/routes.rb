Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users
    get 'dziala', to: 'dziala#index'
  end
end
