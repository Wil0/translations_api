module Api
  module V1
    class TermsController < ApplicationController
      def create
        terms = TermCreateService.new(glossary_id, terms_params).run
        serialize_collection(collection: terms, serializer: TermSerializer, status: 201)
      end

      private

      def terms_params
        params.permit(terms: %i[source_term target_term]).require(:terms)
      end

      def glossary_id
        params.fetch(:glossary_id)
      end
    end
  end
end
