require_relative '../../lib/language_code'

class GlossaryCreateService
  def initialize(glossary_params)
    @source_language_code = glossary_params.fetch(:source_language_code, nil)
    @target_language_code = glossary_params.fetch(:target_language_code, nil)
  end

  def run
    create
  end

  private

  attr_reader :source_language_code, :target_language_code

  def create
    check_params_presence

    Glossary.create!(source_language_code:, target_language_code:)
  end

  def check_params_presence
    LanguageCode.find_by!(code: source_language_code&.downcase)
    LanguageCode.find_by!(code: target_language_code&.downcase)
  end
end
