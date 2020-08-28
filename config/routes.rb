Rails.application.routes.draw do
  root to: 'headline#index'

  get '/search' => 'headline#search'

  resources :search
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
