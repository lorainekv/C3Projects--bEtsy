module ApplicationHelper
  def pretty_time(time)
    time.localtime.strftime("%B %-d, %Y %I:%M %p")
  end
end
