class CreateOrdinance < ActiveRecord::Migration[5.0]
  def change
    create_table :ordinances do |t|
      t.string :name
      t.string :code
      t.string :url
    end
  end
end
