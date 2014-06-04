class AddStatsToItems < ActiveRecord::Migration
  def change
    add_column :items, :attack, :integer
    add_column :items, :strength, :integer
    add_column :items, :agility, :integer
    add_column :items, :intelligence, :integer
    add_column :items, :stamina, :integer
    add_column :items, :defence, :integer
    add_column :items, :armor, :integer
  end
end
