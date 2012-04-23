class ChangeDateFromTimeBanks < ActiveRecord::Migration
  def up
	change_table :time_banks do |t|
      t.change :date, :date
    end
  end

  def down
	change_table :time_banks do |t|
      t.change :date, :datetime
    end
  end
end
