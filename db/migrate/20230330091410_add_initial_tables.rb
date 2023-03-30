class AddInitialTables < ActiveRecord::Migration[7.0]
  def change
    create_table :glossaries do |t|
      t.string  :source_language_code
      t.string  :target_language_code
      t.index %i[source_language_code target_language_code], unique: true, name: :source_target_code

      t.timestamps
    end

    create_table :terms do |t|
      t.string :field

      t.timestamps
    end

    create_table :language_codes do |t|
      t.string :code
      t.string :country

      t.timestamps
    end
  end
end
