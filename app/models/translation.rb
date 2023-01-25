class Translation < ApplicationRecord
  is_verb = proc { |x| x.type == 'verb' }
  validates :word, presence: true, length: { maximum: 50 }
  validates :type, presence: true, inclusion: { in: %w[adjective adverb article conjunction noun preposition pronoun verb] }
  validates :conjugation, :presence, if: is_verb
  validates :example, presence: true
  validates :translation, presence: true, length: { maximum: 50 }

  has_one :language
  has_one :conjugation, if: is_verb, dependent: :destroy
end
