class BattlesController < ApplicationController
	def index
		@battles = Battle.where(:oponent_type => "Robot").reverse!
		@page = 1
	end

	def page
		@page = params[:id].to_i
		@first_state_battles = Battle.where(:oponent_type => "Robot").reverse!

		@second_state_battles = @first_state_battles
		
		@third_state_battles = @second_state_battles.last(@second_state_battles.count - (params[:id].to_i - 1)*20)
        @battles = @third_state_battles.first(20)
	end

	def show 
		@battle = Battle.find(params[:id])
	end

end
