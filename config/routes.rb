# frozen_string_literal: true

Rails.application.routes.draw do # rubocop:disable Metrics/BlockLength
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # admin関連=========================================================
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # =================================================================

  # user関連==========================================================
  devise_scope :user do
    root 'users/sessions#new'
  end

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    confirmations: 'users/confirmations',
    registrations: 'users/registrations'
  }

  namespace :users do
    resources :cars do
      patch 'update_images'
    end
    resources :general_users
    resources :dash_boards, only: [:index]
    resources :articles, only: %i[index show]
    resource :profile, except: %i[create new]
    resource :business, except: %i[index destroy] do
      patch 'update_images'
    end
    resources :workers do
      patch 'update_images'
    end
  end
  # =================================================================

  # manager関連=======================================================
  # devise_for :managers, controllers: {
  #   sessions:      'managers/sessions',
  #   passwords:     'managers/passwords',
  #   confirmations: 'users/confirmations',
  #   registrations: 'managers/registrations'
  # }

  # =================================================================

  # 共通==============================================================
  # 利用規約
  get 'use' => 'use#index'
  # =================================================================
end
