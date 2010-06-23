class AddDayNumberToWorkDays < ActiveRecord::Migration
  def self.up
    add_column :work_days, :day_number, :integer
  end

  def self.down
    remove_column :work_days, :day_number
  end
end
