class AddDailyHoursToTimeBanks < ActiveRecord::Migration
  def change
    add_column :time_banks, :daily_hours, :integer
  end
end
