Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  #devise_for :users

  get 'tags/:tag', to: 'posts#index', as: :tag
  get 'category/:category', to: 'posts#post_by_category', as: :category
  get 'about-us', to: 'pages#about_us', as: :about_us
  get 'contact-us', to: 'pages#contact_us', as: :contact_us

  resources :posts do
    resources :comments
  end

  root 'posts#index'

end
