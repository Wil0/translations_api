class TranslationSerializer < ActiveModel::Serializer
  attributes :id, :glossary_id, :source_text
end
