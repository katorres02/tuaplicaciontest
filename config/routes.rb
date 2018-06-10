Rails.application.routes.draw do
  # no necesitamos las rutas por defecto de devise ya que solo necesitamos su token
  devise_for :users, only: []

  root 'dashboards#index'
  
  namespace :api do
  	# versionamiento de la rest api
  	namespace :v1 do
  		resources :sessions, only: [:create] do
  			collection do
  				post   'login'
  				delete 'logout'
  			end
  		end
  		# nested resources para usuarios ej: /users/1/interests.json
  		resources :users, except: :index do
  			resources :interests
  		end
  	end
  end
end
