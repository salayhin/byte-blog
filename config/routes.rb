Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, path_names: { sign_up: 'register' },
             controllers: {  sessions:            'sessions',
                             registrations:       'registrations',
                             passwords:           'passwords'
             }

  get 'tags/:tag', to: 'posts#index', as: :tag
  get 'category/:category', to: 'posts#post_by_category', as: :category
  get 'about-us', to: 'pages#about_us', as: :about_us
  get 'contact-us', to: 'pages#contact_us', as: :contact_us
  post 'contact-us-submit', to: 'pages#contact_us_submit', as: :contact_us_submit

  resources :posts, path: '' do
    resources :comments
  end

  root 'posts#index'

end
