Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :glossaries, only: %i[index show create] do
        resources :terms, only: [:create]
      end

      resources :translations, only: %i[create show]
    end
  end
end
