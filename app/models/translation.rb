class Translation < ApplicationRecord
  belongs_to :lesson
  has_many :answers, dependent: :destroy
  has_many :tests, through: :answers
  
  # attribute :answer, :string
end
