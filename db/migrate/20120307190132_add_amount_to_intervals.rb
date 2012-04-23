class AddAmountToIntervals < ActiveRecord::Migration
  def change
    add_column :intervals, :amount, :decimal

  end
end
