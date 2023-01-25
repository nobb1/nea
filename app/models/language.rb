class Language < ApplicationRecord
  validates :language, presence: true

  belongs_to :translations
end
