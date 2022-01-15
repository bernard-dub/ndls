Rails.application.routes.draw do
  
  root to: "lessons#index"
  
  devise_for :users
  
  resources :lessons do
    get 'play', on: :member
    post 'result', on: :member
    get 'stats', on: :member
    get 'reset', on: :member
    resources :translations, shallow: true
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
