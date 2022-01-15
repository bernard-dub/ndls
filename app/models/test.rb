class Test < ApplicationRecord
  belongs_to :lesson
  has_many :answers, dependent: :destroy
  has_many :translations, through: :answers
  belongs_to :user
  
  accepts_nested_attributes_for :answers
  
  scope :for_user, lambda { |user|
      where("tests.user_id = ?", user.id)
  } 
  
  
  def maximum_score
    self.answers.size
  end
  
  def percentage_score
    (self.score.to_f / self.maximum_score.to_f*100).to_i
  end
end
