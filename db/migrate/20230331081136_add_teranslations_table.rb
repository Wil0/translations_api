class AddTeranslationsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :translations do |t|
      t.text :source_text, null: false
      t.references :glossary

      t.timestamps
    end
  end
end
