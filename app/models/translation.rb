class Translation < ApplicationRecord
  belongs_to :glossary

  delegate :terms, to: :glossary

  validates :source_text, presence: true, length: { maximum: 5000 }
end
