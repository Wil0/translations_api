class Term < ApplicationRecord
  belongs_to :glossary

  validates :source_term, presence: true
  validates :target_term, presence: true
  validates :source_term, uniqueness: { scope: :target_term }
end
