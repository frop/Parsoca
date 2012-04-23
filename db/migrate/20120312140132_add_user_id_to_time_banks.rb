class AddUserIdToTimeBanks < ActiveRecord::Migration
  def change
    add_column :time_banks, :user_id, :integer

  end
end
