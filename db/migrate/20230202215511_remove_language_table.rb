class RemoveLanguageTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :languages
    remove_column :translations, :language_id
    add_column :translations, :language, :string
  end
end
