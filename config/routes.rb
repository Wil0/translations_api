Rails.application.routes.draw do
  resources :glossaries, only: %i[index show create] do
    resources :terms, only: [:create]
  end
end
