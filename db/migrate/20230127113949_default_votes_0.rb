class DefaultVotes0 < ActiveRecord::Migration[7.0]
  def change
    change_column_default :translations, :votes, 0
  end
end
