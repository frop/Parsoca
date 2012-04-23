class RemoveDailyHoursFromTimeBanks < ActiveRecord::Migration
  def up
    remove_column :time_banks, :daily_hours
      end

  def down
    add_column :time_banks, :daily_hours, :integer
  end
end
