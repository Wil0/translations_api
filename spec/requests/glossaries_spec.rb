RSpec.describe 'Glossaries', type: :request do
  describe 'GET /glossaries' do
    it 'returns the glossary with all the terms' do
      get '/glossaries'

      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(json_response).to eq([{ 'id' => 1, 'target_language_code' => 'zu', 'source_language_code' => 'aa' }])
    end
  end

  describe 'GET /glossaries/:id' do
    context 'glossary exists' do
      it 'returns the glossary' do
        glossary_id = Glossary.first.id
        get "/glossaries/#{glossary_id}"

        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(json_response).to eq({ 'id' => 1, 'target_language_code' => 'zu', 'source_language_code' => 'aa' })
      end
    end

    context 'glossary does not exist' do
      it 'returns empty' do
        get '/glossaries/-1'

        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(json_response).to be_empty
      end
    end
  end

  describe 'POST /glossaries' do
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
