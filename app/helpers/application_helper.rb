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
 
  def profanity_lead(user)
    leads = {
      bisounours: "Apprendre c'est merveilleux !",
      neutre:     "Développe ton potentiel",
      fais_moi_mal: "Ici tu n'as pas droit à l'erreur"
    }
    leads[user.profanity.to_sym]
  end
  
  def profanity_feedback(value,user)
    mode = user.profanity.to_sym
    level = case value
      when (0..20)
        20
      when (21..50)
        50
      when (51..80)
        80
      when (81..99)
        90
      when (100)
        100
    end
    Test.feedback[level][mode].sample
  end
 end
