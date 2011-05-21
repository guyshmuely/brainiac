class Card < ActiveRecord::Base

  belongs_to :course

  def question_direction
    super || 'ltr'
  end

  def solution_direction
    super || 'ltr'
  end

  validates_presence_of(:question)
  validates_presence_of(:solution)
end
