module Api
  module V1
    class TermsController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActiveRecord::RecordInvalid, with: :show_record_errors

      def create
        term = TermCreateService.new(glossary_id, term_params).run
        render json: term, status: 201, serializer: TermSerializer
      end

      private

      def term_params
        params.require(:term).permit(:source_term, :target_term)
      end

      def glossary_id
        params.fetch(:glossary_id)
      end
    end
  end
end
