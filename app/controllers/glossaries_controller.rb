class GlossariesController < ApplicationController
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
