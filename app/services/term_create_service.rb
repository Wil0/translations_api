class TermCreateService
  def initialize(glossary_id, term_params)
    @glossary_id = glossary_id
    @term_params = term_params
  end

  def run
    create
  end

  private

  attr_reader :glossary_id, :term_params

  def create
    term_params.map { |group| group.each { |k, v| group[k] = v&.downcase } }
    glossary.terms.create!(term_params)
  end

  def glossary
    @glossary = Glossary.find(glossary_id)
  end
end
