Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, param: :_username
  resources :messages, only: %i[new create destroy index]
  resources :receivers, only: %i[new create index]

  get 'users/(:_username)/messages', to: 'users#messages'
  get 'users/(:_username)/received_messages', to: 'users#received_messages'
  get 'users/(:_username)/unread_messages', to: 'users#unread_messages'
  get 'users/(:_username)/inbox', to: 'users#inbox'
end
