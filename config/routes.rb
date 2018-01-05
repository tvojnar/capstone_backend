Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # for now just have an index action, but later I will add show, create, edit, update actions as well
  scope :api do
    resources :hikes, only: [:index, :create]
  end
end
