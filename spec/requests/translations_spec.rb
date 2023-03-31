require 'rails_helper'

RSpec.describe 'Translations', type: :request do
  let(:glossary) { Glossary.first }

  describe 'GET /show' do
    context 'Translation record does not exist' do
      it 'returns not found' do
        get '/translations/-1'

        json_response = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response).to eq({ 'errors' => 'Translation record not found with the attributes provided' })
      end

      context 'Translation record does exist' do
        it 'returns not found' do
          get '/translations/1'

          json_response = JSON.parse(response.body)
          expected_json = {
            'source_text' => 'This is a recruitment task.',
            'glossary_terms' => ['recruitment'],
            'highlighted_source_text' => 'This is a <HIGHLIGHT>recruitment</HIGHLIGHT> task.'
          }

          expect(response).to have_http_status(:ok)
          expect(json_response).to eq(expected_json)
        end
      end
    end
  end

  describe 'POST /create' do
    context 'valid params' do
      let(:params) do
        { translation:
          { source_text: 'some text to translate',
            source_language_code: glossary.source_language_code,
            target_language_code: glossary.target_language_code } }
      end

      it 'creates a Translation record' do
        post('/translations', params:)

        json_response = JSON.parse(response.body)
        expect(response).to have_http_status(:created)
        expect(json_response).to eq({ 'glossary_id' => 1,
                                      'id' => 2,
                                      'source_text' => 'some text to translate' })
      end
    end

    context 'invalid params' do
      let(:invalid_params) do
        { translation:
          { source_text: nil,
            source_language_code: glossary.source_language_code,
            target_language_code: glossary.target_language_code } }
      end
      context 'no source_text provided' do
        it 'returns errors' do
          post('/translations', params: invalid_params)

          json_response = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_response).to eq({ 'errors' => "Source text can't be blank" })
        end
      end

      context 'source_text is too long' do
        it 'returns errors' do
          invalid_params[:translation][:source_text] = 'a' * 5001
          post('/translations', params: invalid_params)

          json_response = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_response).to eq({ 'errors' => 'Source text is too long (maximum is 5000 characters)' })
        end
      end

      context 'glossary does not match language code params is too long' do
        it 'returns errors' do
          invalid_params[:translation][:source_text] = 'some text'
          invalid_params[:translation][:glossary_id] = 99_999
          post('/translations', params: invalid_params)

          json_response = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(json_response).to eq({ 'errors' => 'Glossary record not found with the attributes provided' })
        end
      end
    end
  end
end
