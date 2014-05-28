class AdminController < ApplicationController
	def index
		if current_user.nil? || current_user.admin.nil? 
			redirect_to root_path 
		end
		redirect_to admin_users_path
	end

	def users
		if current_user.nil? || current_user.admin.nil? 
			redirect_to root_path 
		end
		@users = User.all
	end

	def ban
		b = BanList.create(:user_id => params[:id])

		respond_to do |format|
	      format.js { render action: "action" }
	    end
	end

	def unban
		BanList.create(:user_id => params[:id]).find_by_user_id(params[:id]).destroy
		
		respond_to do |format|
	      format.js { render action: "action" }
	    end
	end

	def items
		if current_user.nil? || current_user.admin.nil? 
			redirect_to root_path 
		end
		@item = Item.new
		@items = Item.all
	end

	def mobs
		if current_user.nil? || current_user.admin.nil? 
			redirect_to root_path 
		end
	end
end
