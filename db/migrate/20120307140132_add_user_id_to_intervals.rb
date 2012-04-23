class AddUserIdToIntervals < ActiveRecord::Migration
  def change
    add_column :intervals, :user_id, :integer

  end
end
