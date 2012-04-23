class AddValueToTimeBanks < ActiveRecord::Migration
  def change
    add_column :time_banks, :value, :integer

  end
end
