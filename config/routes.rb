Tww::Application.routes.draw do

  devise_for :users
  devise_scope :user do
    match 'profile' => 'devise/registrations#show'
  end

  localized do
    get 'loans', to: 'loans#index', as: :loans
    get 'loans/:id', to: 'loans#show', as: :loan
    get 'loans/:id/gallery', to: 'loans#gallery', as: :gallery
  end

  get 'update_template', to: 'application#update_template'

  root to: 'loans#index'
end
