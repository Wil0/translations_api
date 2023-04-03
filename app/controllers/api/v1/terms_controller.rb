module Api
  module V1
    class TermsController < ApplicationController
      def create
        term = TermCreateService.new(glossary_id, term_params).run
        serialize_object(object: term, serializer: TermSerializer, status: 201)
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
