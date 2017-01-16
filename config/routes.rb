Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'portal#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
	#get '/print/:person_id/:ordinance', to: 'portal#print', as: :print
	resources :comments
	resources :contacts
	resources :assignments do
    collection do
      get 'print/:id', action: 'print', as: 'print' # return a pdf of the assignments
    end
  end

end
