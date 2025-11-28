Rails.application.routes.draw do
  resources :challenges do
    resource :chat, only: %i[show create]
    collection do # so that it doesn't create id
      get :create_with_ai # ai created challenge
    end
  end
  resources :chats, only: [] do
    resources :messages, only: [:create] do
      collection do
        delete :destroy_all
      end
    end
  end
  devise_for :users
  authenticated :user do
    root to: 'challenges#index', as: :authenticated_root
  end
  devise_scope :user do
    root to: 'devise/sessions#new', as: :unauthenticated_root
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
