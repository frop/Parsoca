class Interval < ActiveRecord::Base
  belongs_to :user

  after_destroy :recalculate_timebank
  after_save :recalculate_timebank

  # Exclude password info from json output.
  def to_json(options={})
    options[:except] ||= [:created_at, :updated_at]
    super(options)
  end

  def end=(time)
	  if self.start < time
		  amount_will_change!
		  self.amount = (time - self.start)/60 
	  end

	  super(time)
  end

  def retroactive?
	  self.start < Date.today
  end

  def recalculate_timebank
    TimeBank.recalculate(self.user, self) unless self.end.nil?
  end

end
