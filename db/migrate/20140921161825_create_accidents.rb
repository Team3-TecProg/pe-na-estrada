class CreateAccidents < ActiveRecord::Migration
  def change
    create_table :accidents do |t|
      t.string :latitude
      t.string :longitude
      t.string :federative_unity
      t.integer :kilometer
      t.string :highway_number

      t.timestamps
    end
  end
end
