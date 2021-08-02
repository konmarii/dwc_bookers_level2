Rails.application.routes.draw do

  get 'chats/show'
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  resources :users, only: [:index, :show, :edit, :update] do
    get 'follower' => 'users#follower', as: 'follower'
    get 'followed' => 'users#followed', as: 'followed'
    post 'follow/:id' => 'relationships#follow', as: 'follow'
    post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
  end

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  get 'search' => 'searches#search'
<<<<<<< HEAD
=======
  
>>>>>>> f73b5d07069a16881d68c7a87d5a813763664248
  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create]

end
