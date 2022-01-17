Rails.application.routes.draw do
  
  root to: "lessons#index"
  
  devise_for :users
  
  get 'user/:id/profanity/:profanity', to: 'users#update', as: 'profanity'
  
  resources :lessons do
    # get 'play', on: :member
    get 'play(/:reverse)', on: :member, to: 'lessons#play', as: 'play'
    post 'result', on: :member
    get 'stats', on: :member
    get 'reset', on: :member
    resources :translations, shallow: true
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
