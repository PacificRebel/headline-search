Rails.application.routes.draw do
  root to: 'headline#index'

  get '/search' => 'headline#search'
  post '/search' => 'headline#search'

  resources :search, controller: 'headline_controller'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
