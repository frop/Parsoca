class ReportsController < ApplicationController
  before_filter :authenticate_user!

  def daily
    @days = Report.daily(current_user)
    @daily_hours = current_user.basic.daily_hours
    @current_time_bank = current_user.time_banks.last.value

    respond_to do |format|
      format.html # daily.html.erb
      format.json # daily.json.erb
    end
  end

end
