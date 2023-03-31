class TermSerializer < ActiveModel::Serializer
  attributes :id, :source_term, :target_term
end
