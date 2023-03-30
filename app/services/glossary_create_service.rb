class GlossaryCreateService
  attr_reader :source_language_code, :target_language_code, :errors

  def initialize(glossary_params)
    @source_language_code = glossary_params.fetch(:source_language_code, nil)
    @target_language_code = glossary_params.fetch(:target_language_code, nil)
    @errors = []
  end

  def run
    create
  end

  private

  def create
    check_params_presence
    return @errors if @errors.any?

    begin
      Glossary.create!(source_language_code:, target_language_code:)
    rescue ActiveRecord::RecordInvalid => e
      @errors << e
    end

    @errors
  end

  def check_params_presence
    if !source_language_code || !target_language_code
      @errors << 'source_language_code and target_language_code must be present'
    end

    source_language = LanguageCode.find_by(code: source_language_code&.downcase)
    target_language = LanguageCode.find_by(code: target_language_code&.downcase)
    @errors << 'source is not valid.' unless source_language
    @errors << 'target is not valid.' unless target_language
  end
end
