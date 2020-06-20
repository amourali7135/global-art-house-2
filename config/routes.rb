Rails.application.routes.draw do
  # get 'photos/create'
  # get 'users/index'
  # get 'users/new'
  # get 'users/create'
  # get 'users/show'
  # get 'users/update'
  # get 'users/destroy'
  # get 'users/edit'
  # get 'shopping_carts/index'
  # get 'shopping_carts/new'
  # get 'shopping_carts/create'
  # get 'shopping_carts/show'
  # get 'shopping_carts/update'
  # get 'shopping_carts/destroy'
  # get 'shopping_carts/edit'
  # get 'reactions/index'
  # get 'reactions/new'
  # get 'reactions/create'
  # get 'reactions/show'
  # get 'reactions/update'
  # get 'reactions/destroy'
  # get 'reactions/edit'
  # get 'payments/index'
  # get 'payments/new'
  # get 'payments/create'
  # get 'payments/show'
  # get 'payments/update'
  # get 'payments/destroy'
  # get 'payments/edit'
  # get 'orders/index'
  # get 'orders/new'
  # get 'orders/create'
  # get 'orders/show'
  # get 'orders/update'
  # get 'orders/destroy'
  # get 'orders/edit'
  # get 'conversations/index'
  # get 'conversations/new'
  # get 'conversations/create'
  # get 'conversations/show'
  # get 'conversations/update'
  # get 'conversations/destroy'
  # get 'conversations/edit'
  # get 'artists/index'
  # get 'artists/new'
  # get 'artists/create'
  # get 'artists/show'
  # get 'artists/update'
  # get 'artists/destroy'
  # get 'artists/edit'
  # get 'likes/index'
  # get 'likes/new'
  # get 'likes/create'
  # get 'likes/show'
  # get 'likes/update'
  # get 'likes/destroy'
  # get 'likes/edit'
  # get 'followers/index'
  # get 'followers/new'
  # get 'followers/create'
  # get 'followers/show'
  # get 'followers/update'
  # get 'followers/destroy'
  # get 'followers/edit'
  # get 'art_tags/index'
  # get 'art_tags/new'
  # get 'art_tags/create'
  # get 'art_tags/show'
  # get 'art_tags/update'
  # get 'art_tags/destroy'
  # get 'art_tags/edit'
  # get 'comments/index'
  # get 'comments/new'
  # get 'comments/create'
  # get 'comments/show'
  # get 'comments/update'
  # get 'comments/destroy'
  # get 'comments/edit'
  # get 'arts/index'
  # get 'arts/new'
  # get 'arts/create'
  # get 'arts/show'
  # get 'arts/update'
  # get 'arts/destroy'
  # get 'arts/edit'

  devise_for :users

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/artists_countries/', to: 'artists#countries', as: :artist_country #guido moved this to the top!



  resources :artists do
    resources :arts
  end

  #Wtf is this array?  I dont' even remember.
  resources :arts, only: [] do
    resources :comments, only: [:create, :destroy]
  end



  # resources :arts, only: [:show, :edit, :update, :destroy] do
  #   # resources :comments, only: [:index, :create, :destroy], shallow: true
  #   # resources :likes, only: [:create, :destroy], shallow: true
  #   resources :photos, only: [:create]
  # end

  resources :cart_products, only: [:destroy]
  resources :shopping_carts, only: [:show] do
    resources :orders, only: [:new, :create]
  end

  resources :orders, only: [:show, :create] do
    resources :payments, only: [:new, :create]
  end

  resources :follows, only: [:index]

  # mount StripeEvent::Engine, at: '/stripe-webhooks'


  get 'about', to: 'pages#about', as: 'about'
  get 'explore', to: 'pages#explore', as: 'explore'
  get "help", to: "pages#help", as: 'help'
  get 'contact', to: 'pages#contact', as: 'contact'
  get 'dashboard', to: 'pages#dashboard', as: 'dashboard'
  get 'country', to: 'pages#country', as: 'country'
  get 'city', to: 'pages#city', as: 'city'
  get 'browse', to: 'pages#browse', as: 'browse'
  get 'following', to: 'pages#following', as: 'following'
  get 'followers', to: 'pages#followers', as: 'followers'
  get 'liked', to: 'pages#liked', as: 'liked'

  get 'art/:id/likes', to: 'arts#likes', as: :art_likes
  get 'art/:id/unlike', to: 'arts#unlikes', as: :art_unlikes
  get 'artist/:id/like', to: 'artists#like', as: :artist_like
  get 'artist/:id/unlike', to: 'artists#unlike', as: :artist_unlike
  get 'artist/:id/follow', to: 'artists#follow', as: :artist_follow
  get 'artist/:id/unfollow', to: 'artists#unfollow', as: :artist_unfollow
  get 'artist/:id/followers', to: 'artists#followers', as: :artist_followers

  get '/search' => 'search#index'

  # resources :photos, only: :destroy

  # resources :messages, only: [:new, :create]
  # resources :conversations, only: [:index, :show, :new]

  resources :conversations do
    resources :messages
  end

  get 'tags/:tag', to: 'arts#index', as: :tag



end
