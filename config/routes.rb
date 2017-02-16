Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'portal#index'
  get '/debug', to: 'portal#debug'
  get '/auth/familysearch', as: 'login'
  get '/auth/familysearch/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :comments
  resources :contacts
  resources :assignments do
    collection do
      get 'print/:id', action: 'print', as: 'print' # return a pdf of the assignments
    end
  end

end
