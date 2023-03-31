require 'rails_helper'

RSpec.describe 'Terms', type: :request do
  describe 'POST /create' do
    context 'valid params' do
      it 'creates a record' do
        params = { term: {
          source_term: 'bye',
          target_term: 'adios'
        } }

        post("/glossaries/#{Glossary.first.id}/terms", params:)
        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(:created)
        expect(json_response).to eq({ 'id' => 2, 'source_term' => 'bye', 'target_term' => 'adios' })
      end
    end

    context 'invalid params' do
      let(:params) do
        { term: {
          source_term: Term.first.source_term,
          target_term: Term.first.target_term
        } }
      end

      describe 'Term record already exists' do
        it 'returns an error' do
          post("/glossaries/#{Glossary.first.id}/terms", params:)

          json_response = JSON.parse(response.body)
          errors = 'Source term has already been taken'

          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_response).to eq({ 'errors' => errors })
        end
      end

      describe 'Glossary record does not exist' do
        it 'returns an error' do
          post('/glossaries/-1/terms', params:)
          json_response = JSON.parse(response.body)

          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_response).to eq({ 'errors' => 'Glossary record not found with the attributes provided' })
        end
      end
    end
  end
end
