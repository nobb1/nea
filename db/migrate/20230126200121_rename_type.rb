class RenameType < ActiveRecord::Migration[7.0]
  def change
    rename_column :translations, :type, :word_type
  end
end
