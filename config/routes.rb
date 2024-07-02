Rails.application.routes.draw do
  resources :users, only: [:index, :create] do
    collection do
      get 'filter', to: 'users#filter'
    end
  end
end
