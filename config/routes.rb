Rails.application.routes.draw do
  resources :tagoverlaps
  resources :tagexcepts
  resources :sources
  resources :pages
  
   root 'pages#index'
   get 'loadnews', to: 'pages#load'
   get 'analyze', to: 'pages#analyze'
   get 'category/:category', to: 'pages#index', as: :category
   get 'data', to: 'pages#index', as: :data
   get 'atags', to: 'pages#atags'
   get 'tag_cloud', to: 'pages#tag_cloud'
   get 'tags/:tag', to: 'pages#index', as: :tag
  # get 'data/:data', to: 'pages#index', as: :data
   get 'info', to: 'pages#info'
 end
