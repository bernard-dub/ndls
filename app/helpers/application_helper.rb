module ApplicationHelper
  def format_date(date)
    date.strftime("%d/%m/%y - %H:%M")
  end
  
  def links_to_test_and_reverse(lesson)
		"<div class='btn-group col width-auto' role='group' aria-label='Link to play'>\n
		  #{link_to "<-", play_lesson_path(id:lesson,reverse:'reverse'), class:"btn btn-lg btn-warning"}\n
		  <button type='button' class='btn btn-lg btn-warning' inactive>Commencer le test :</button>\n
		  #{link_to "->", play_lesson_path(id:lesson), class:"btn btn-lg btn-warning"}\n
		</div>".html_safe
  end
  
end
