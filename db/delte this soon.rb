class CreateTranslations < ActiveRecord::Migration[7.0]
  def change
    create_table :translations do |t|
      t.string :word
      t.string :type
      t.string :language
      t.text :example
      t.string :translation
      t.integer :votes

      t.timestamps
    end
    add_reference :translations, :user, null: false, foreign_key: true
  end
end
