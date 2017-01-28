class CommentsController < ApplicationController
	def create
		params[:comment][:user_id] = current_user.id
		@comment = Comment.new(params.require(:comment).permit(:comments,:user_id,:person_id))
		@comment.save
		redirect_to :root
	end

	def update
		params[:comment][:user_id] = current_user.id
		@comment = current_user.comments.where( person_id: params[:comment][:person_id] ).first
		@comment.comments = params[:comment][:comments]
		@comment.save
		redirect_to :root
	end

	def edit
		@comment = current_user.comments.where( person_id: params[:id] ).first_or_initialize
		@person = current_user.people.find( params[:id] )
	end

	def destroy
	end
end
