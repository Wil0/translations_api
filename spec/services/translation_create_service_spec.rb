RSpec.describe TranslationCreateService, type: :service do
  describe '.run' do
    let(:glossary) { Glossary.first }
    let(:params) do
      { source_text: 'some text to translate', source_language_code: glossary.source_language_code,
        target_language_code: glossary.target_language_code }
    end

    context 'valid params' do
      it 'creates a Term record' do
        expect { TranslationCreateService.new(params).run }.to change(Translation, :count).by(1)
      end
    end

    context 'invalid params' do
      let(:invalid_params) do
        { source_text: 'some text to translate', source_language_code: glossary.source_language_code,
          target_language_code: glossary.target_language_code, glossary_id: 2 }
      end

      describe 'glossary_id does not match with provided language sources' do
        it 'does not create a Translation record' do
          translation_service = TranslationCreateService.new(invalid_params)

          expect do
            translation_service.run
          end.to raise_error(ActiveRecord::RecordNotFound).and change(Translation, :count).by(0)
        end
      end

      describe 'source_text is not provided' do
        it 'does not create a Translation record' do
          invalid_params[:source_text] = nil
          invalid_params[:glossary_id] = glossary.id
          translation_service = TranslationCreateService.new(invalid_params)

          expect do
            translation_service.run
          end.to raise_error(ActiveRecord::RecordInvalid,
                             "Validation failed: Source text can't be blank").and change(Translation, :count).by(0)
        end
      end

      describe 'source_text is too long' do
        it 'does not create a Translation record' do
          invalid_params[:source_text] = 'a' * 5001
          invalid_params[:glossary_id] = glossary.id
          translation_service = TranslationCreateService.new(invalid_params)

          expect do
            translation_service.run
          end.to raise_error(ActiveRecord::RecordInvalid,
                             'Validation failed: Source text is too long (maximum is 5000 characters)')
            .and change(Translation, :count).by(0)
        end
      end

      describe 'target_language_code is not provided' do
        it 'does not create a Translation record' do
          invalid_params[:target_language_code] = nil
          invalid_params[:glossary_id] = glossary.id
          translation_service = TranslationCreateService.new(invalid_params)

          expect do
            translation_service.run
          end.to raise_error(InvalidParamsError,
                             'source and target language code must be present')
            .and change(Translation, :count).by(0)
        end
      end
    end
  end
end
