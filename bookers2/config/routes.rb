Rails.application.routes.draw do

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

end
