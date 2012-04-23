class CreateTimeBanks < ActiveRecord::Migration
  def change
    create_table :time_banks do |t|
      t.integer :base

      t.timestamps
    end
  end
end
