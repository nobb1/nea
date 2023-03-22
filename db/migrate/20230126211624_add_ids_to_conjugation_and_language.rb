class AddIdsToConjugationAndLanguage < ActiveRecord::Migration[7.0]
  def change
    add_reference :conjugations, :translation, null: false, foregin_key: true
  end
end
