class AddIdsToConjugationAndLanguage < ActiveRecord::Migration[7.0]
  def change
    change_table :languages do |t|
      t.bigint :translation_id
    end
    change_table :conjugations do |t|
      t.bigint :translation_id
    end
    add_foreign_key :languages, :translations
    add_foreign_key :conjugations, :translations
  end
end
