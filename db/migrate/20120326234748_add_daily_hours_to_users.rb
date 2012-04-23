class AddDailyHoursToUsers < ActiveRecord::Migration
  def change
    add_column :users, :daily_hours, :integer

  end
end
