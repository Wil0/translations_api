class GlossarySerializer < ActiveModel::Serializer
  attributes :id, :target_language_code, :source_language_code
  has_many :terms
end
