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
    translation_source_text_terms.map(&:downcase)
    @glossary_terms ||= translation.terms
                                   .where(source_term: translation_source_text_terms)
                                   .pluck(:source_term)
  end

  def highlighted_source_text
    translation_source_text_terms.map do |word|
      glossary_terms.include?(word) ? "<HIGHLIGHT>#{word}</HIGHLIGHT>" : word
    end
  end

  def translation_source_text_terms
    translation.source_text.gsub('.', '').strip.split
  end

  def translation
    @translation ||= Translation.find(translation_id)
  end
end
