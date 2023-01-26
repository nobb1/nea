class CreateTranslations < ActiveRecord::Migration[7.0]
  def change
    create_table :translations do |t|
      t.string :word
      t.string :type
      t.text :example
      t.string :translation
      t.integer :votes

      t.timestamps
    end
    add_foreign_key :translations, :languages, :language_id
    add_foreign_key :translations, :conjugations, :conjugation_id
  end
end
