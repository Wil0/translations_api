Rails.application.routes.draw do
  resources :glossaries, only: [:create]
end
