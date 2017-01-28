class ContactsController < ApplicationController
	def new
		@contact = Contact.new
		render action: :edit
	end

	def create
		params[:contact][:user_id] = current_user.id
		@contact = Contact.new(params.require(:contact).permit(:user_id,:first_nm,:last_nm,:email,:phone,:notes))
    if @contact.save
      redirect_to action: :index
    else
      render :edit
    end
	end

	def update
		params[:contact][:user_id] = current_user.id
		contact = current_user.contacts.find( params[:id] )
		contact.update(params.require(:contact).permit(:user_id,:first_nm,:last_nm,:email,:phone,:notes))
		contact.save!
		redirect_to action: :index
	end

	def edit
		@contact = current_user.contacts.find( params[:id] )
	end

	def destroy
		contact = current_user.contacts.find( params[:id] )
		contact.destroy!
		redirect_to action: :index
	end

	def index
		@contacts = current_user.contacts
	end
end
