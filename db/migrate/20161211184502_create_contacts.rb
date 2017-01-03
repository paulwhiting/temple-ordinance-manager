class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :first_nm, null: false
      t.string :last_nm, null: false
      t.string :email
      t.string :phone
      t.string :notes

			t.timestamps
    end
		add_reference :contacts, :user, index: true, foreign_key: true
  end
end
