class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :text_content
      t.timestamps
    end
    add_reference :comments, :translation, null: false, foreign_key: true
    add_reference :comments, :user, null: false, foregin_key: true
    add_column :comments, :votes, :integer
  end
end
