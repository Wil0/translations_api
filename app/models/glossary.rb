class Glossary < ApplicationRecord
  has_many :terms
  has_many :translations

  validates :source_language_code, presence: true
  validates :target_language_code, presence: true
  validates :source_language_code, uniqueness: { scope: :target_language_code }
end
