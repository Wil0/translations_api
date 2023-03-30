class GlossariesController < ApplicationController
  def index
    render json: Glossary.all, status: 200, each_serializer: GlossarySerializer
  end

  def show
    glossary = Glossary.find_by(id: params[:id])
    return render json: {}, status: 200 unless glossary

    render json: glossary, status: 200, serializer: GlossarySerializer
  end

  def create
    errors = GlossaryCreateService.new(glossary_params).run

    if errors.any?
      render json: { errors: }, status: 422
    else
      render json: {}, status: 201
    end
  end

  private

  def glossary_params
    params.require(:glossary).permit(:source_language_code, :target_language_code)
  end
end
