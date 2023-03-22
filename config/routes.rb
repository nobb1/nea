Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'user/sessions' }
  resources :translations do
    resources :comments, shallow: true
  end
  get "search", to: "translations#search"
  get "language", to: "translations#change_language"
  match "vote", to: "translations#vote", via: :post
  match "translations/comments/:id/vote", to: "comments#vote", via: :post
  # Defines the root path route ("/")
  root to: "translations#index"
end
