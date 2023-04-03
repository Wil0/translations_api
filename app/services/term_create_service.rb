class TermCreateService
  def initialize(glossary_id, term_parmas)
    @glossary_id = glossary_id
    @source_term = term_parmas.fetch(:source_term, nil)
    @target_term = term_parmas.fetch(:target_term, nil)
  end

  def run
    create
  end

  private

  attr_reader :glossary_id, :source_term, :target_term

  def create
    glossary.terms.create!(source_term: source_term&.downcase, target_term: target_term&.downcase)
  end

  def glossary
    @glossary = Glossary.find(glossary_id)
  end
end
