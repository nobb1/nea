class AddAndRemoveIds < ActiveRecord::Migration[7.0]
  def change
    change_table :translations do |t|
      t.bigint :language_id
    end
    add_foreign_key :translations, :languages
    remove_column :languages, :translation_id
  end
end
