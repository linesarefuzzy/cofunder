Tww::Application.routes.draw do

  devise_for :users
  devise_scope :user do
    match 'profile' => 'devise/registrations#show', via: [:get, :post]
  end

  localized do
    resources :loans, only: [:index, :show]
    get 'loans/:id/gallery', to: 'loans#gallery', as: :gallery
  end

  get 'update_template', to: 'application#update_template'

  root to: 'loans#index'
end
