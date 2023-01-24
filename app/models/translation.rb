class Translation < ApplicationRecord
  validates :word, presence: true, length: { maximum: 50 }
  validates :type, presence: true, inclusion: { in: %w[adjective adverb article conjunction noun preposition pronoun verb] }
  validates :conjugation, :presence, if: proc { |x| x.type == 'verb' }
  validates :example, presence: true
  validates :translation, presence: true
  has_one :language
end
