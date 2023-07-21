RSpec.describe Api::V1::GlossariesController, type: :request do
  describe 'GET /glossaries' do
    it 'returns the glossary with all the terms' do
      get '/api/v1/glossaries'
      expected_json = [{ 'id' => 1, 'source_language_code' => 'en', 'target_language_code' => 'es',
                         'terms' => [{ 'id' => 1, 'source_term' => 'cup', 'target_term' => 'taza' }] }]

      expect(response).to have_http_status(:ok)
      expect(json_response).to eq(expected_json)
    end
  end

  describe 'GET /glossaries/:id' do
    context 'glossary exists' do
      it 'returns the glossary' do
        glossary_id = Glossary.first.id
        get "/api/v1/glossaries/#{glossary_id}"

        expect(response).to have_http_status(:ok)
        expect(json_response).to eq({
                                      'id' => 1,
                                      'source_language_code' => 'en',
                                      'target_language_code' => 'es',
                                      'terms' => [{ 'id' => 1, 'source_term' => 'cup', 'target_term' => 'taza' }]
                                    })
      end
    end

    context 'glossary does not exist' do
      it 'returns empty' do
        get '/api/v1/glossaries/-1'

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response).to eq({ 'errors' => 'Glossary record not found with the attributes provided' })
      end
    end
  end

  describe 'POST /glossaries' do
    context 'valid params' do
      let(:params) do
        { glossary: { source_language_code: 'it', target_language_code: 'es' } }
      end

      it 'returns http success' do
        post('/api/v1/glossaries', params:)

        expected_json = {
          'id' => 2,
          'source_language_code' => 'it',
          'target_language_code' => 'es',
          'terms' => []
        }

        expect(response).to have_http_status(:created)
        expect(json_response).to eq(expected_json)
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

          post('/api/v1/glossaries', params:)

          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_response).to eq({ 'errors' => 'Source language code has already been taken' })
        end
      end

      describe 'target_language_code is not in the list' do
        it 'returns an error' do
          params = { glossary:
              {
                source_language_code: Glossary.first.source_language_code,
                target_language_code: 'XX'
              } }

          post('/api/v1/glossaries', params:)

          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_response).to eq({ 'errors' => 'LanguageCode record not found with the attributes provided' })
        end
      end

      describe 'source_language_code is not in the list' do
        it 'returns an error' do
          params = { glossary:
              {
                source_language_code: 'XX',
                target_language_code: Glossary.first.source_language_code
              } }

          post('/api/v1/glossaries', params:)

          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_response).to eq({ 'errors' => 'LanguageCode record not found with the attributes provided' })
        end
      end
    end
  end
end
