require 'csv'
require_relative '../lib/language_code.rb'

text_file = File.read(Rails.root.join('lib', 'language-codes.csv'))
csv = CSV.parse(text_file, headers: true, encoding: 'utf-8')

csv.each do |row|
  LanguageCode.create!(row.to_hash)
end

source_language_code = "en"
target_language_code = "es"
glossary = Glossary.create!(source_language_code:, target_language_code:)

terms_list = [{source_term: 'cup', target_term: 'taza'}]
glossary.terms.create!(terms_list)
glossary.translations.create!(source_text: "This is a cup for you")

