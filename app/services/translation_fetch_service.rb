class TranslationFetchService
  attr_reader :translation_id

  def initialize(translation_id)
    @translation_id = translation_id
  end

  def run
    fetch_translation
  end

  private

  def fetch_translation
    {
      source_text: translation.source_text,
      glossary_terms:,
      highlighted_source_text: highlighted_source_text.join(' ')
    }
  end

  def glossary_terms
    translation_source_text_terms = translation.source_text.split.map(&:downcase)
    @glossary_terms ||= translation.terms
                                   .select(:source_term)
                                   .where(source_term: translation_source_text_terms)
                                   .map(&:source_term)
  end

  def translation
    @translation ||= Translation.find(translation_id)
  end

  def highlighted_source_text
    translation.source_text.split.map { |word| glossary_terms.include?(word) ? "<HIGHLIGHT>#{word}</HIGHLIGHT>" : word }
  end
end
