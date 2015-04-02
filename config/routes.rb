 Rails.application.routes.draw do

  root 'welcome#index'

  get 'sign-up', to: 'registrations#new'
  post 'sign-up', to: 'registrations#create'
  get 'sign-out', to: 'authentication#destroy'
  get 'sign-in', to: 'authentication#new', as: "signin"
  post 'sign-in', to: 'authentication#create'


  get 'terms' => 'terms#index'
  get 'about' => 'about#index'
  get '/faq'  => 'common_questions#index'

  get 'stories' => 'pivotaltracker#show'
  
  resources :users

  resources :projects do
    resources :tasks
    resources :memberships
  end

  resources :tasks, only: [] do
    resources :comments, only: [:create]
  end
end
