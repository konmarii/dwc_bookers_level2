Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  resources :users, only: [:index, :show, :edit, :update] do
    get 'follower' => 'users#follower', as: 'follower'
    get 'followed' => 'users#followed', as: 'followed'
    post 'follow/:id' => 'relationships#follow', as: 'follow'
    post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
    get "search" => "users#search"
  end

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  get 'search' => 'searches#search'
  get 'chats/show'
  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create]

  resources :groups, only: [:index, :show, :new, :create, :edit, :update, :destroy]  do
    member do
      get :join
      get :leave
    end
    get "join" =>"groups#join"
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end
end
