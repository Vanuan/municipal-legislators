Rails.application.routes.draw do
  get 'static', to: 'application#static'

  resources :people
end
