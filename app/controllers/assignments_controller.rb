class AssignmentsController < ApplicationController
	def create
		params[:assignment][:user_id] = current_user.id
		assignment = Assignment.new(params.require(:assignment).permit(:user_id,:contact_id,:person_id,:ordinance_nm))
		assignment.save!
		redirect_to root_path
	end

	def update
		params[:assignment][:user_id] = current_user.id
		assignment = current_user.assignments.find( params[:id] )
		assignment.update(params.require(:assignment).permit(:user_id,:notes))
		assignment.save!
		redirect_to root_path
	end

	def edit
		@assignment = current_user.assignments.find( params[:id] )
	end

	def destroy
		assignment = current_user.assignments.find( params[:id] )
		assignment.destroy!
		redirect_to :back
	end

	def index
		@assignments = current_user.assignments
	end
end
