require 'sidekiq/web'
require 'sidekiq-status/web'
require 'sidetiq/web'
Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Sidekiq::Web, at: "/sidekiq"
  
  devise_for :users
  resources :tagoverlaps
  resources :tagexcepts
  resources :sources do
    resources :infos
  end  
  resources :pages
  resources :sourcehtmls

  root 'pages#index'
  get 'loadnews', to: 'pages#load'
  get 'analyze', to: 'pages#analyze'
  get 'category/:category', to: 'pages#index', as: :category
  get 'ss', to: 'pages#index'
  get 'data', to: 'pages#index', as: :data
  get 'atags', to: 'pages#atags', controller: 'tag'
  get 'tag_cloud', to: 'pages#tag_cloud'
  get 'tags/:tag', to: 'pages#index', as: :tag
  # get 'data/:data', to: 'pages#index', as: :data
  get 'info', to: 'infos#info'
  get 'remove_tags',  controller: 'tag', to: 'tag#rtags'
  get 'tagexport', to:   'pages#tagexport', controller: 'tag'
  get 'tagimport', to:   'pages#tagimport', controller: 'tag'
  get 'search_tags', to: 'pages#search_tags'
  post 'search_tags', to: 'pages#index'
  get 'redis', to: 'pages#redis'
  get 'rss', to: 'pages#rss'
  get 'infoday', to: 'infos#infoday'
  get 'infoday1', to: 'infos#infoday1'
  get 'infotoday', to: 'infos#infotoday'
  get 'html', to: 'sourcehtmls#html'
  get 'tmp', to: 'pages#tmp'
  get 'sourceexport', to:   'sources#sourceexport'
  get 'sourceimport', to:   'sources#sourceimport'
  get 'tagexceptexport',  controller: 'tag', to: 'tag#tagexceptexport'
  get 'tagexceptimport',  controller: 'tag', to: 'tag#tagexceptimport'
  get 'tagoverlapexport',  controller: 'tag', to: 'tag#tagoverlapexport'
  get 'tagoverlapimport',  controller: 'tag', to: 'tag#tagoverlapimport'
end
