module Api
  module V1
    class GlossariesController < ApplicationController
      def index
        serialize_collection(collection: Glossary.all, serializer: GlossarySerializer)
      end

      def show
        glossary = Glossary.find(params[:id])
        serialize_object(object: glossary, serializer: GlossarySerializer)
      end

      def create
        glossary = GlossaryCreateService.new(glossary_params).run
        serialize_object(object: glossary, serializer: GlossarySerializer, status: :created)
      end

      private

      def glossary_params
        params.require(:glossary).permit(:source_language_code, :target_language_code)
      end
    end
  end
end
