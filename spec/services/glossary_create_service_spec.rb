RSpec.describe GlossaryCreateService, type: :service do
  describe '.run' do
    context 'valid params' do
      let(:params) do
        { source_language_code: LanguageCode.last.code.upcase, target_language_code: LanguageCode.first.code }
      end

      it 'creates a Glossary record' do
        expect { GlossaryCreateService.new(params).run }.to change(Glossary, :count).by(1)
      end
    end

    context 'invalid params' do
      describe 'source_language_code does not exist' do
        it 'does not create a Glossary record' do
          invalid_params = { source_language_code: 'xx', target_language_code: 'YY' }
          glossary_service = GlossaryCreateService.new(invalid_params)

          expect do
            glossary_service.run
          end.to raise_error(ActiveRecord::RecordNotFound).and change(Glossary, :count).by(0)
        end
      end

      describe 'record already exist' do
        it 'does not create a new record' do
          invalid_params = {
            source_language_code: Glossary.first.source_language_code,
            target_language_code: 'XX'
          }

          glossary_service = GlossaryCreateService.new(invalid_params)

          expect do
            glossary_service.run
          end.to raise_error(ActiveRecord::RecordNotFound).and change(Glossary, :count).by(0)
        end
      end
    end
  end
end
