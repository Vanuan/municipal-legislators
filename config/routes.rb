Rails.application.routes.draw do
  get 'static', to: 'application#static'

  root to: 'application#index'

  resources :people
end
