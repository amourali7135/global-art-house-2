Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "registrations" }

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #how the fuck can I do this the right way?
  get '/artists_countries/', to: 'artists#countries', as: :artist_country #guido moved this to the top!

  #9820 I added the two paths for the pivot.  Get rid of them if they become problematic.
  resources :artists, :path => 'creators' do
    resources :arts, except: :index, :path => 'creation'
    resources :articles, except: :index
    resources :services, except: :index
    resources :collaborations, except: :index
    resources :lessons, except: :index
    resources :events, except: :index
  end

  #Wtf is this array?  I dont' even remember.
  resources :arts, only: [] do
    # resources :comments, only: [:create, :destroy]
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
  get 'team', to: 'pages#team', as: 'team'
  get 'career', to: 'pages#career', as: 'career'
  get 'updates', to: 'pages#updates', as: 'updates'
  get 'blog', to: 'pages#blog', as: 'blog'
  get 'articles', to: 'pages#articles', as: 'articles'
  get 'collaborations', to: 'pages#collaborations', as: 'collaborations'
  get 'services', to: 'pages#services', as: 'services'
  get 'lessons', to: 'pages#lessons', as: 'lessons'


  get 'art/:id/likes', to: 'arts#likes', as: :art_likes
  get 'art/:id/unlike', to: 'arts#unlikes', as: :art_unlikes
  get 'artist/:id/like', to: 'artists#like', as: :artist_like
  get 'artist/:id/unlike', to: 'artists#unlike', as: :artist_unlike
  get 'artist/:id/follow', to: 'artists#follow', as: :artist_follow
  get 'artist/:id/unfollow', to: 'artists#unfollow', as: :artist_unfollow
  get 'artist/:id/followers', to: 'artists#followers', as: :artist_followers
  get 'articles/:id/likes', to: 'articles#likes', as: :articles_likes
  get 'articles/:id/unlike', to: 'articles#unlikes', as: :articles_unlikes
  get 'services/:id/like', to: 'services#likes', as: :services_likes
  get 'services/:id/unlike', to: 'services#unlikes', as: :services_unlikes
  get 'collaborations/:id/like', to: 'collaborations#likes', as: :collaborations_likes
  get 'collaborations/:id/unlike', to: 'collaborations#unlikes', as: :collaborations_unlikes
  get 'lessons/:id/like', to: 'lessons#likes', as: :lessons_likes
  get 'lessons/:id/unlike', to: 'lessons#unlikes', as: :lessons_unlikes

  get '/search' => 'search#index'

  # resources :photos, only: :destroy

  # resources :messages, only: [:new, :create]
  # resources :conversations, only: [:index, :show, :new]

  resources :conversations do
    resources :messages
  end

  get 'tags/:tag', to: 'arts#index', as: :tag

  mount Commontator::Engine => '/commontator'

  resources :subscriptions, only: [:new, :create, :destroy]

  resources :jobs


  # kinds = %w|IPA brown_ale pilsner lager lambic hefweizen|
  # get 'beers/:kind' => 'beers#kind', constraints: {kind: Regexp.new(kinds.join('|'))}

  # Figure out the country/name
  # get 'country', to: 'pages#country', as: 'country'


end
