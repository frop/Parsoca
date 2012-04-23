class FixIntervalAmountScale < ActiveRecord::Migration
  def up
    change_table :intervals do |t|
      t.change :amount, :decimal, :scale => 2
    end
  end

  def down
    change_table :intervals do |t|
      t.change :amount, :decimal
    end
  end
end
