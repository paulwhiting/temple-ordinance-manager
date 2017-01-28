class CreateAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :assignments do |t|
      t.string :notes

			t.timestamps
    end

		add_reference :assignments, :user, index: true, foreign_key: true
		add_reference :assignments, :person, index: true, foreign_key: true
		add_reference :assignments, :contact, index: true, foreign_key: true
		add_reference :assignments, :ordinance, index: true, foreign_key: true
		add_reference :assignments, :status, index: true, foreign_key: true, null: true
  end
end
