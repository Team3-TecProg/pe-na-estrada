class Addranking_positionToHighway < ActiveRecord::Migration
  def change
    add_column :highways, :ranking_position, :integer
  end
end
