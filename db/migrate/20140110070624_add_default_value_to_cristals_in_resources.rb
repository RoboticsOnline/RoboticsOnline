class AddDefaultValueToCristalsInResources < ActiveRecord::Migration
  def change
  	change_column :resources, :cristals, :integer, :default => 3
  end
end
