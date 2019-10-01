class DropUserFromArts < ActiveRecord::Migration[5.2]
  def change
    remove_reference :arts, :user, index: true
  end
end
