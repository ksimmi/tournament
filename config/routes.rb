Rails.application.routes.draw do
  root to: 'tournaments#index'

  resources :tournaments, only: [:index, :show]
  resources :groups, only: [] do
    member do
      get 'play_matches'
    end
  end
end
