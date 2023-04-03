module Api
  module V1
    class TranslationsController < ApplicationController
      def create
        translation = TranslationCreateService.new(translation_params).run
        serialize_object(object: translation, serializer: TranslationSerializer, status: :created)
      end

      def show
        translation = TranslationFetchService.new(params[:id]).run
        render json: translation, status: :ok
      end

      private

      def translation_params
        params.require(:translation).permit(:source_language_code, :target_language_code, :source_text, :glossary_id)
      end
    end
  end
end
