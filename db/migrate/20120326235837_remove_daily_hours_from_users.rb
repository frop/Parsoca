class RemoveDailyHoursFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :daily_hours
      end

  def down
    add_column :users, :daily_hours, :integer
  end
end
