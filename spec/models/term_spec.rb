RSpec.describe Term, type: :model do
  context 'relationships' do
    describe 'glossary' do
      it 'has a glossary foreing_key' do
        new_term = described_class.new(source_term: 'foo', target_term: 'bar')

        expect(new_term).not_to be_valid
        expect(new_term.errors.messages).to eq({ glossary: ['must exist'] })
      end
    end
  end

  context 'validations' do
    describe 'uniqueness' do
      it 'raises an error if the record already exists' do
        glossary = Glossary.first
        new_term = described_class.new(source_term: glossary.terms.first.source_term,
                                       target_term: glossary.terms.first.target_term,
                                       glossary:)

        expect(new_term).not_to be_valid
        expect(new_term.errors.messages).to eq({ source_term: ['has already been taken'] })
      end
    end
  end
end
