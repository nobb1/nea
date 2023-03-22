class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { in: 3..16 }

  has_many :translations, dependent: :destroy
  has_many :comments, dependent: :destroy
end
