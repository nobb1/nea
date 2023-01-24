class CreateTranslations < ActiveRecord::Migration[7.0]
  def change
    create_table :translations do |t|
      t.string :word
      t.string :type
      t.text :conjugation
      t.text :example
      t.string :translation
      t.integer :votes

      t.timestamps
    end
  end
end
