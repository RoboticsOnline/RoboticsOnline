class AddUsernameToRobots < ActiveRecord::Migration
  def change
  		add_column :robots, :name, :string
  end
end
