Rails.application.routes.draw do
	scope :api, defautls: {format: :json} do
		devise_for :users, controllers: { sessions: 'sessions', passwords: 'passwords' },
                       path_names: { sign_in: :login }
    resource :user, only: [:show, :update]
	end
  namespace :api do
    resources :articles do
    	member do
    		post :create_comment
    	end
    end
  end
end
