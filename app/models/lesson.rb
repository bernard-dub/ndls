class Lesson < ApplicationRecord
  has_many :translations
  accepts_nested_attributes_for :translations
  belongs_to :user
  
  has_many :tests
  
  def overall_score_for(user)
    self.tests.for_user(user).map{|t|t.score}.sum
  end
  
  def maximum_possible_score_for(user)
    self.tests.for_user(user).map{|t|t.answers.count}.sum
  end
  
  def percentage_score_for(user)
    unless self.tests.for_user(user).empty?
      (self.overall_score_for(user).to_f/self.maximum_possible_score_for(user).to_f*100).round(2)
    else
      "-"
    end
  end
end
