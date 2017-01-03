class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :person_id, null: false
      t.string :comments, null: false

			t.timestamps
    end
		add_reference :comments, :user, index: true, foreign_key: true
  end
end
