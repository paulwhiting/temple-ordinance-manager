class AssignmentsController < ApplicationController
	def create
    ordinance = Ordinance.find( params[:assignment][:ordinance_id] )
    person = current_user.people.find( params[:assignment][:person_id] )

    if ordinance.name != "SealingChildToParents" && ordinance.name != "SealingToSpouse"
      params[:assignment][:user_id] = current_user.id
      assignment = Assignment.new(params.require(:assignment).permit(:user_id,:contact_id,:person_id,:ordinance_id))
      assignment.save!
      redirect_to root_path
    else
      render plain: "Assignments for sealings are not supported at this time."
    end
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
    # first we need to update the ordinance statuses
    people = current_user.assignments.incomplete.joins(:person).pluck(:fs_pid).uniq
    people.each do |person_id|
      response = current_user.client.get("/platform/tree/persons/#{person_id}/ordinances")
      response.body['persons'].each do |person|
        person['ordinances'].each do |ord|
          which = ord['type']
          status = ord['status']
          assignment = Assignment.joins(:ordinance).joins(:person).where('people.fs_pid = ?', person_id).where( 'ordinances.url = ?', which ).first
          if assignment
            assignment.status_id = Status.where( url: status ).pluck( :id ).first
            assignment.save!
          end
        end
      end
    end
		@contacts_with_assignments = current_user.contacts.with_assignments.uniq
	end

	# /print/:ids
	def print
    if params[:id].include?(',')
      ids = params[:id].split ','
    else
      ids = [params[:id]]
    end
    work = {}
    ids.each do |id|
      assignment = current_user.assignments.find(id)
      ord = {type:"http://lds.org/#{assignment.ordinance.name}"}
      if work[assignment.person.fs_pid] 
        work[assignment.person.fs_pid].append( ord )
      else
        work[assignment.person.fs_pid] = [ord]
      end
    end

    request = []
    work.each_key do |key|
      request <<= {id: key, ordinances: work[key]}
    end
    b_hash = {persons: request}

		#b_hash = {persons:[{id:params[:person_id], ordinances: [{type:"http://lds.org/#{params[:ordinance]}"}]}]}
		b_json = b_hash.to_json

		#b_json = '{"id":"1234"}'
    begin
      response = current_user.client.post '/platform/reservations/print-sets', b_json, content_type: 'application/x-fs-v1+json'
      pdf = current_user.client.get( response['location'], nil, accept: 'application/pdf' )
      render body: pdf.body, content_type: 'application/pdf'
    rescue FamilySearch::Error::ClientError => e
      render plain: e
    end
    
	end
end
