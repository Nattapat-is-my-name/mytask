Rails.application.routes.draw do
  resources :tasks do
    member do
      get :confirm_delete
    end
  end
  root "tasks#index"
end
