RSpec.describe TranslationFetchService, type: :service do
  describe '.run' do
    context 'translation exists' do
      let(:translation_record) { Translation.first }

      context 'there are matching terms for the translation' do
        it 'returns the highlighted terms' do
          translation = TranslationFetchService.new(translation_record.id).run
          expect(translation).to eq({ source_text: 'This is a recruitment task.',
                                      glossary_terms: ['recruitment'],
                                      highlighted_source_text: 'This is a <HIGHLIGHT>recruitment</HIGHLIGHT> task.' })
        end
      end

      context 'there are no matching terms for the translation' do
        it 'returns no highlighted terms' do
          translation_record.update!(source_text: 'I am all new')
          translation = TranslationFetchService.new(translation_record.id).run
          expect(translation).to eq({ glossary_terms: [],
                                      highlighted_source_text: 'I am all new',
                                      source_text: 'I am all new' })
        end
      end
    end

    context 'translation does not exist' do
      it 'raises an error' do
        expect do
          TranslationFetchService.new(-1).run
        end.to raise_error(ActiveRecord::RecordNotFound,
                           "Couldn't find Translation with 'id'=-1")
      end
    end
  end
end
