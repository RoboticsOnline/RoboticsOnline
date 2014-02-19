class RenameInteligenceToIntelligenceInStats < ActiveRecord::Migration
  def change	
  	rename_column :stats, :inteligence, :intelligence
  end
end
