Rails.application.routes.draw do
  resources :glossaries, only: %i[index show create]
end
