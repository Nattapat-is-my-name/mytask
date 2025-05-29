Rails.application.routes.draw do
  resources :tasks, except: [ :show, :edit ] do
    member do
      get :confirm_delete
    end
  end
  root "tasks#index"
end
