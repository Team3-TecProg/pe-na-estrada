class AddHighwayToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :highway, index: true
  end
end
