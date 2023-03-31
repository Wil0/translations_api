class Glossary < ApplicationRecord
  has_many :terms
  validates :source_language_code, uniqueness: { scope: :target_language_code }
end
