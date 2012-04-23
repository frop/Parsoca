module TimeBanksHelper
  def to_hours(minutes)
    h = (minutes.abs/60).to_i
    m = (minutes.abs%60).to_i
    
#    signal = '-' if minutes < 0
    hours = sprintf("%02d:%02d", h, m)
    "#{hours}"
  end

  def hours_span_class(min)
    if min > 0
      'success'
    elsif min < 0
      'important'
    else
      'info'
    end
    
  end

  def resource_name
    :user
  end
end
