module LessonsHelper
  def full_score_percentage(lesson,user)
    lesson.percentage_score_for(user).to_f.round(0)
  end
  
  def full_score_absolute(lesson,user)
    "#{lesson.overall_score_for(user)} / #{lesson.maximum_possible_score_for(user)}"
  end
  
  def set_color(score)
    if score.to_i >= 90
      'success'
    elsif score.to_i >= 60
      'warning'
    else
      'danger'
    end
  end
end
