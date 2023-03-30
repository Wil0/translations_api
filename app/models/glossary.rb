class Glossary < ApplicationRecord
  validates :source_language_code, uniqueness: { scope: :target_language_code }
end
