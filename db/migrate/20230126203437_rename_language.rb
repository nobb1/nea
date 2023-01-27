class RenameLanguage < ActiveRecord::Migration[7.0]
  def change
    rename_column :languages, :language, :language_name
  end
end
