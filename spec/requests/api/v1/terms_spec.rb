RSpec.describe Api::V1::TermsController, type: :request do
  describe 'POST /create' do
    context 'valid params' do
      it 'creates a record' do
        params = {
          terms: [
            {
              source_term: 'bye',
              target_term: 'adios'
            },
            { source_term: 'hello',
              target_term: 'hola' }
          ]
        }

        post("/api/v1/glossaries/#{Glossary.first.id}/terms", params:)

        expect(response).to have_http_status(:created)
        expect(json_response).to eq([{ 'id' => 2, 'source_term' => 'bye', 'target_term' => 'adios' },
                                     { 'id' => 3, 'source_term' => 'hello', 'target_term' => 'hola' }])
      end
    end

    context 'invalid params' do
      let(:params) do
        { terms: [{
          source_term: Term.first.source_term,
          target_term: Term.first.target_term
        }] }
      end

      describe 'Term record already exists' do
        it 'returns an error' do
          post("/api/v1/glossaries/#{Glossary.first.id}/terms", params:)

          errors = 'Source term has already been taken'

          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_response).to eq({ 'errors' => errors })
        end
      end

      describe 'Glossary record does not exist' do
        it 'returns an error' do
          post('/api/v1/glossaries/-1/terms', params:)

          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_response).to eq({ 'errors' => 'Glossary record not found with the attributes provided' })
        end
      end
      describe 'A key/value pair from the group params is invalid ' do
        it 'returns an error' do
          params[:terms] << { source_term: nil, target_term: nil }
          post("/api/v1/glossaries/#{Glossary.first.id}/terms", params:)

          errors = 'Source term has already been taken'

          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_response).to eq({ 'errors' => errors })
        end
      end
    end
  end
end
