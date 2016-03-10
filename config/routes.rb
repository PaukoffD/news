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
 end
