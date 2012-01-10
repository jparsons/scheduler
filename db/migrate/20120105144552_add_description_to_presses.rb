class AddDescriptionToPresses < ActiveRecord::Migration
  def self.up
    add_column :presses, :description, :string
    Press.all.each do |press|
      name, description = press.name.split("- ")
      press.name = name
      press.description = description
      press.save
    end
  end

  def self.down
    remove_column :presses, :description
  end
end
