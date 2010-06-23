class CreateHolidays < ActiveRecord::Migration
  def self.up
    create_table :holidays do |t|
      t.date :date
      t.string :name
      t.text :note
      t.timestamps
    end
  end
  
  def self.down
    drop_table :holidays
  end
end
