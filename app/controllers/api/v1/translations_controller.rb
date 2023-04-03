module Api
  module V1
    class TranslationsController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActiveRecord::RecordInvalid, with: :show_record_errors

      def create
        translation = TranslationCreateService.new(translation_params).run
        render json: translation, status: :created, serializer: TranslationSerializer
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
