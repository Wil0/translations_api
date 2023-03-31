class InvalidParamsError < StandardError
end

class TranslationCreateService
  attr_reader :source_language_code, :target_language_code, :source_text, :glossary_id

  def initialize(translation_params)
    @source_language_code = translation_params.fetch(:source_language_code, nil)
    @target_language_code = translation_params.fetch(:target_language_code, nil)
    @source_text = translation_params.fetch(:source_text, nil)
    @glossary_id = translation_params.fetch(:glossary_id, nil)
  end

  def run
    create
  end

  private

  def create
    if !source_language_code || !target_language_code
      raise InvalidParamsError, 'source and target language code must be present'
    end

    glossary.translations.create!(source_text:)
  end

  def glossary
    @glossary ||= if glossary_id
                    Glossary.find_by!(id: glossary_id, source_language_code:, target_language_code:)
                  else
                    Glossary.find_by!(source_language_code:, target_language_code:)
                  end
    @glossary
  end
end
