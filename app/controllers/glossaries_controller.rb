class GlossariesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :show_record_errors

  def index
    render json: Glossary.all, status: 200, each_serializer: GlossarySerializer
  end

  def show
    glossary = Glossary.find(params[:id])
    render json: glossary, status: 200, serializer: GlossarySerializer
  end

  def create
    glossary = GlossaryCreateService.new(glossary_params).run
    render json: glossary, status: 201, serializer: GlossarySerializer
  end

  private

  def glossary_params
    params.require(:glossary).permit(:source_language_code, :target_language_code)
  end
end
