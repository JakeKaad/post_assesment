module ApplicationHelper

  def spacer
    "  |  "
  end

  def fix_date_time(time)
    time.strftime("%B %d, '%y at %I:%M%p %Z")
  end
end
