class AddInFightToRobots < ActiveRecord::Migration
  def change
  		add_column :robots, :in_fight, :boolean, :default => false
  end
end
