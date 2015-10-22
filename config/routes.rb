Rails.application.routes.draw do
  resources :task, except: [:new]
  root 'task#index'
end
