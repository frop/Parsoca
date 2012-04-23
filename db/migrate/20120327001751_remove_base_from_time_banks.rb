class RemoveBaseFromTimeBanks < ActiveRecord::Migration
  def up
    remove_column :time_banks, :base
      end

  def down
    add_column :time_banks, :base, :integer
  end
end
