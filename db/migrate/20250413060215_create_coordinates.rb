class CreateCoordinates < ActiveRecord::Migration[7.2]
  def change
    create_table :coordinates do |t|
      t.string :title
      t.text :memo

      t.timestamps
    end
  end
end
