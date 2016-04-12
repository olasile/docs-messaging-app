Rails.application.routes.draw do
  match "/websocket", :to => ActionCable.server, via: [:get, :post]
  
  devise_for :users, controllers: { registrations: 'registrations' }
  
  root 'conversations#index'

  resources :messages 
  resources :stats, only: [:create]
  
  resources :documents do
    delete 'destroy_all', on: :collection
    post :upload, on: :collection
  end
  
  resource :contacts_files, only: [:new, :create]

  get :browse, to: 'browse#index'
  
  resources :contacts, except: [:edit, :update] do
    delete :destroy_all, on: :collection
    post :search, on: :collection
  end

  resources :conversations, except: [:edit, :update] do
    delete :destroy_all, on: :collection
    post :search, on: :collection

    resources :messages, only: [:new, :create, :index]
  end

  get 'admin', to: 'admin/users#index'

  namespace :admin do
    
    resources :users do 
      resources :contacts

      resources :conversations do
        resources :messages
      end
    end

    resources :conversations do
      resources :messages
    end
    
    resources :companies, :documents
  end
end
