class AddAttackedToBattles < ActiveRecord::Migration
  def change
  		add_column :battles, :attacked, :boolean
  end
end
