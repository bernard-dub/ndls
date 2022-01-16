class Answer < ApplicationRecord
  belongs_to :test
  belongs_to :translation
  
  before_destroy do
    self.test.update(score: (self.test.score-1))
  end
end
