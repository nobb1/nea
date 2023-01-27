class AddForeignKeysToTranslations < ActiveRecord::Migration[7.0]
  def change
    change_table :translations do |t|
      t.bigint :language_id
      t.bigint :conjugation_id
    end
    add_foreign_key :translations, :languages
    add_foreign_key :translations, :conjugations
  end
end
