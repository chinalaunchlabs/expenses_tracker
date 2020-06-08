Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      post 'sign_up' => 'authentication#sign_up'
      post 'sign_in' => 'authentication#sign_in'
    
      resources :categories, only: [:index]

      resources :records do 
        collection do
          get 'overview'
          get 'seed'
        end
      end

    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
