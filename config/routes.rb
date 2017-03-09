Rails.application.routes.draw do
  root 'home#index'
  resources :rooms do
    resources :messages
  end
  post 'sign_in' => 'home#signin'
  delete 'sign_out' => 'home#signout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
