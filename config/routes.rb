Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    resources :glossaries, only: %i[index show create] do
      resources :terms, only: [:create]
    end

    resources :translations, only: %i[create show]
  end
end
