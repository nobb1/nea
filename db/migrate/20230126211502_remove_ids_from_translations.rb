class RemoveIdsFromTranslations < ActiveRecord::Migration[7.0]
  def change
    remove_column :translations, :language_id
    remove_column :translations, :conjugation_id
  end
end
