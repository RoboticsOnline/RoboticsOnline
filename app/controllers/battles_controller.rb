class BattlesController < ApplicationController
  	def index
  		@battles = Battle.where(:oponent_type => "Robot")
  	end

	def show 
		@battle = Battle.find(params[:id])
	end

end
