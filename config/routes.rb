Rails.application.routes.draw do
  get 'translations/create'
  resources :glossaries, only: %i[index show create] do
    resources :terms, only: [:create]
  end

  resources :translations, only: [:create]
end
