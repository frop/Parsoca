class AddDateToTimeBanks < ActiveRecord::Migration
  def change
    add_column :time_banks, :date, :datetime

  end
end
