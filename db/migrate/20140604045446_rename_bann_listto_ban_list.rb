class RenameBannListtoBanList < ActiveRecord::Migration
  def change
  	rename_table :bann_lists, :ban_lists
  end
end
