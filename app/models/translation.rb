class Translation < ApplicationRecord
  validates :word, presence: true, length: { maximum: 50 }
  validates :language, presence: true, inclusion: { in: %w[spanish french] }
  validates :word_type, presence: true, inclusion: { in: %w[adjective adverb article conjunction noun preposition pronoun verb] }
  validates :conjugation, presence: proc { |x| x.type == 'verb' }
  validates :example, presence: true
  validates :word_translation, presence: true, length: { maximum: 50 }
  validates :user_id, presence: true

  has_one :conjugation, -> { where 'verb' == :word_type }, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :conjugation
end
