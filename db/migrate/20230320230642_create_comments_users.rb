class CreateCommentsUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :comments_users do |t|

      t.timestamps
    end
    add_reference :comments_users, :comment, null: false, foreign_key: true
    add_reference :comments_users, :user, null: false, foreign_key: true
  end
end
