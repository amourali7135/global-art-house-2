class AddUserReferenceToArts < ActiveRecord::Migration[5.2]
  def change
    add_reference :arts, :user, index: true
  end
end
