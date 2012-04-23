class CreateBasics < ActiveRecord::Migration
  def change
    create_table :basics do |t|
      t.integer :user_id
      t.integer :daily_hours
      t.integer :time_bank

      t.timestamps
    end
  end
end
