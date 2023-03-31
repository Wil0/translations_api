RSpec.describe Translation, type: :model do
  context 'relationships' do
    describe 'glossary' do
      it 'has a glossary foreing_key' do
        new_translation = described_class.new(source_text: 'Some text here')

        expect(new_translation).not_to be_valid
        expect(new_translation.errors.messages).to eq({ glossary: ['must exist'] })
      end
    end
  end

  context 'validations' do
    describe 'presence' do
      it 'raises an error if the source_text is not present' do
        new_glossary = described_class.new(glossary: Glossary.first)

        expect(new_glossary).not_to be_valid
        expect(new_glossary.errors.messages).to eq({ source_text: ["can't be blank"] })
      end
    end

    describe 'length' do
      it 'raises an error if the source_text is too long' do
        new_glossary = described_class.new(glossary: Glossary.first, source_text: 'i' * 5001)

        expect(new_glossary).not_to be_valid
        expect(new_glossary.errors.messages).to eq({ source_text: ['is too long (maximum is 5000 characters)'] })
      end
    end
  end
end
