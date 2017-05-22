Rails.application.routes.draw do
  devise_for :users

  resources :boards do
    collection do
      post 'import'
    end

    resources :lists, only: [:new, :create], shallow: true do
      resources :cards, only: :create
    end
  end

  resource :user_configuration, only: [:edit, :update]

  root 'boards#index'
end
