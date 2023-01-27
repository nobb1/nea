class RenameTranslation < ActiveRecord::Migration[7.0]
  def change
    rename_column :translations, :translation, :word_translation
  end
end
