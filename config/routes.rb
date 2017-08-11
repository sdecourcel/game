Rails.application.routes.draw do
mount Attachinary::Engine => "/attachinary"

  get 'contact', to: "pages#contact"
  get 'about', to: "pages#about"

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root to: "pages#home"
  resources :events do
    collection do
      get 'myevents', to: "events#myevents"
    end
    member do
    resources :participations, only: [:update, :create]
    end
  end
end
