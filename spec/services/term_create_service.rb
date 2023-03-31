RSpec.describe TermCreateService, type: :service do
  describe '.run' do
    let(:glossary_id) { Glossary.first.id }
    let(:params) do
      { source_term: 'this', target_term: 'esto' }
    end

    context 'valid params' do
      it 'creates a Term record' do
        expect { TermCreateService.new(glossary_id, params).run }.to change(Term, :count).by(1)
      end
    end

    context 'invalid params' do
      describe 'source_term is not provided' do
        it 'does not create a Term record' do
          invalid_params = { target_term: 'YY' }
          term_service = TermCreateService.new(glossary_id, invalid_params)

          expect do
            term_service.run
          end.to raise_error(ActiveRecord::RecordInvalid,
                             "Validation failed: Source term can't be blank").and change(Glossary, :count).by(0)
        end
      end

      describe 'target_term is not provided' do
        it 'does not create a Term record' do
          invalid_params = { source_term: 'YY' }
          term_service = TermCreateService.new(glossary_id, invalid_params)

          expect do
            term_service.run
          end.to raise_error(ActiveRecord::RecordInvalid,
                             "Validation failed: Target term can't be blank").and change(Glossary, :count).by(0)
        end
      end

      describe 'glossary record not found' do
        it 'does not create a Term record' do
          term_service = TermCreateService.new(-1, params)

          expect do
            term_service.run
          end.to raise_error(ActiveRecord::RecordNotFound,
                             "Couldn't find Glossary with 'id'=-1").and change(Glossary, :count).by(0)
        end
      end
    end
  end
end
