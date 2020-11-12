Rails.application.routes.draw do
  namespace :api do
    resources :articles do
    	member do
    		post :create_comment
    	end
    end
  end
end
