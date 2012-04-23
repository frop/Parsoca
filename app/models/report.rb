class Report < ActiveRecord::Base
  belongs_to :user
  
  # Exclude password info from json output.
  def self.daily(user)
    user.intervals.group("strftime('%d/%m/%Y', start)").order('start ASC').sum("amount")
  end

end
