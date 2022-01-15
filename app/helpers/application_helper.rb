module ApplicationHelper
  def format_date(date)
    date.strftime("%d/%m/%y - %H:%M")
  end
end
