class CreateTranslationsVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :translations_users do |t|

      t.timestamps
    end
    add_reference :translations_users, :translation, null: false, foreign_key: true
    add_reference :translations_users, :user, null: false, foreign_key: true
  end
end
