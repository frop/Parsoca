class TimeBank < ActiveRecord::Base
  belongs_to :user
  
  def self.from_hours(hours)
    h,m = hours.split(":")
    if h.to_i > 0
      h.to_i * 60 + m.to_i
    else
      h.to_i * 60 - m.to_i
    end
  end
  
  def self.calculate(user, current_interval)
    last_time_bank = user.time_banks.where('date < ?', current_interval.start).order('date DESC').first
    last_time_bank_value =  (last_time_bank.nil?) ? (user.basic.time_bank || 0) : last_time_bank.value
    
    date = current_interval.start.to_date.to_formatted_s(:db)
    current_time_bank = user.time_banks.find(:first, :conditions => ["DATE(date) = ?", current_interval.start.to_date])

    if current_time_bank.nil? #abrindo banco para hoje
      new_time_bank = user.time_banks.new
      new_time_bank.date = current_interval.start
      new_time_bank.value = last_time_bank_value - user.basic.daily_hours # desconta a jornada do banco se foi o primeiro intervalo do dia
    else #editando banco
      new_time_bank = current_time_bank
    end
    puts new_time_bank.value
    new_time_bank.value += current_interval.amount unless current_interval.amount.nil?
    puts new_time_bank.value
    puts "--"
    new_time_bank.save
    
  end
  
  # TODO REFACTOR!!!
  def self.recalculate(user, interval)
    date = interval.start.to_date
    user.time_banks.find(:all, :conditions => ['DATE(date) >= ?', date]).each { |t| t.destroy } # deleta todos pra frente pra recalcular

    user.intervals.find(:all, :order => 'start ASC', :conditions => ['DATE(start) >= ?', date]).each { |i|
      self.calculate(user, i)
    }

#    user.time_banks.find(:all, :conditions => ['DATE(date) >= ?', date]).each { |t|
#		if user.intervals.find(:all, :conditions => ['DATE(start) > ?', t.date.to_date]).count > 0
#	    	t.value -= amount
#	    	t.save
#		else
#			t.destroy
#		end 
#    }
    
  end
end
