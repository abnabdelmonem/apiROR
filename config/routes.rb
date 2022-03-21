Rails.application.routes.draw do

  concern :reactable do
    resources :reactions, :except => [:show, :update]
  end

  resources :posts, concerns: :reactable do
    resources :comments, concerns: :reactable  do
      resources :replies, concerns: :reactable , :except => [:show]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/signup', to: 'users#create'
  post '/login', to: 'users#login'
end
