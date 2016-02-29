Rails.application.routes.draw do
  devise_for :users
  resources :textbooks
  root "textbooks#welcome"
end
