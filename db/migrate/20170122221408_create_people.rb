class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :fs_pid

      t.timestamps
    end

		add_reference :people, :user, index: true, foreign_key: true
  end
end
