class Answer < ApplicationRecord
  belongs_to :test
  belongs_to :translation
end
