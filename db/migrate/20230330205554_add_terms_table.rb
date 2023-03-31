class AddTermsTable < ActiveRecord::Migration[7.0]
  def change
     create_table :terms do |t|
      t.string  :source_term, null: false
      t.string  :target_term, null: false
      t.references :glossary
      t.index %i[source_term target_term], unique: true

      t.timestamps
    end
  end
end
