class CreateConjugations < ActiveRecord::Migration[7.0]
  def change
    create_table :conjugations do |t|
      t.string :present_i
      t.string :present_you
      t.string :present_hesheit
      t.string :present_we
      t.string :present_youall
      t.string :present_they

      t.timestamps
    end
  end
end
