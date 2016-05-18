class CreateAccidents < ActiveRecord::Migration
  def change
    create_table :accidents do |t|
      t.string :latitude
      t.string :longitude
      t.string :uf
      t.integer :km
      t.string :highway_number

      t.timestamps
    end
  end
end
