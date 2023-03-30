RSpec.describe 'Glossaries', type: :request do
  describe 'POST /create' do
    context 'valid params' do
      let(:params) do
        { glossary: { source_language_code: LanguageCode.last.code, target_language_code: LanguageCode.first.code } }
      end
      it 'returns http success' do
        expect { post('/glossaries', params:) }.to change(Glossary, :count)
        expect(response).to have_http_status(:created)
      end
    end

    context 'invalid params' do
      describe 'Glossary record already exists' do
        it 'returns an error' do
          params = { glossary:
            {
              source_language_code: Glossary.first.source_language_code,
              target_language_code: Glossary.last.target_language_code
            } }

          post('/glossaries', params:)

          json_response = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_response).to eq({ 'errors' => ['Validation failed: Source language code has already been taken'] })
        end
      end

      describe 'target_language_code is not in the list' do
        it 'returns an error' do
          params = { glossary:
              {
                source_language_code: Glossary.first.source_language_code,
                target_language_code: 'XX'
              } }

          post('/glossaries', params:)

          json_response = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_response).to eq({ 'errors' => ['target is not valid.'] })
        end
      end

      describe 'source_language_code is not in the list' do
        it 'returns an error' do
          params = { glossary:
              {
                source_language_code: 'XX',
                target_language_code: Glossary.first.source_language_code
              } }

          post('/glossaries', params:)

          json_response = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_response).to eq({ 'errors' => ['source is not valid.'] })
        end
      end
    end
  end
end
