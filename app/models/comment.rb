class Comment < ApplicationRecord
  validates :text_content, presence: true, length: { in: 2..200 }

  belongs_to :translation
  belongs_to :user
end
