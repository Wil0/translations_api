RSpec.describe Glossary, type: :model do
  context 'validations' do
    describe 'uniqueness' do
      it 'raises an error if the record already exists' do
        new_glossary = described_class.new(source_language_code: Glossary.first.source_language_code,
                                           target_language_code: Glossary.first.target_language_code)

        expect(new_glossary).not_to be_valid
        expect(new_glossary.errors.messages).to eq({ source_language_code: ['has already been taken'] })
      end
    end
  end
end
