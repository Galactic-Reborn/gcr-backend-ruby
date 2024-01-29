Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users
    get 'messages', to: 'messages#message'
  end
end
