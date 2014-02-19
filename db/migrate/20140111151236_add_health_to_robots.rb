class AddHealthToRobots < ActiveRecord::Migration
  def change
  		add_column :robots, :health, :integer, :default=>1000
  end
end
