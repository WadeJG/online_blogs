Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get '/search_blog' => 'welcome#search_blog', as: :search_blog
  get '/search' => 'welcome#search', as: :search

  namespace :my_house do
    root 'blogs#index'
    resources :blogs do
      resources :blog_images, only: [:create, :destroy, :index]
    end
    resources :sessions, only: [:new, :create, :destroy]
    resources :blog_files, only: [:create, :destroy, :index] do
      get 'download_file', on: :member
    end
  end

  resources :blogs, only: [:show] do 
    resources :comments, only: [:index, :create, :destroy]
  end

  match "*path", to: "welcome#error_404", via: :all
end
