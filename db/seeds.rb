require 'csv'

text_file = File.read(Rails.root.join('lib', 'language-codes.csv'))
csv = CSV.parse(text_file, headers: true, encoding: 'utf-8')

csv.each do |row|
  LanguageCode.create!(row.to_hash)
end

source_language_code = LanguageCode.first.code
target_language_code = LanguageCode.last.code
Glossary.create!(source_language_code:, target_language_code:)
