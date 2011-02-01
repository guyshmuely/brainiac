class Card < ActiveRecord::Base

  belongs_to :course

  def question_direction
    super || 'ltr'
  end

  def solution_direction
    super || 'ltr'
  end

end
