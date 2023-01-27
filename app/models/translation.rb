class Translation < ApplicationRecord
  validates :word, presence: true, length: { maximum: 50 }
  validates :language, presence: true
  validates :word_type, presence: true, inclusion: { in: %w[adjective adverb article conjunction noun preposition pronoun verb] }
  validates :conjugation, presence: proc { |x| x.type == 'verb' }
  validates :example, presence: true
  validates :word_translation, presence: true, length: { maximum: 50 }

  belongs_to :language
  has_one :conjugation, -> { where 'verb' == :word_type }, dependent: :destroy

  accepts_nested_attributes_for :language
  accepts_nested_attributes_for :conjugation
end
