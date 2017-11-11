Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :pages
  resources :analyses
  get 'messages/:id' => 'messages#show'
  root to: 'pages#index'
end
