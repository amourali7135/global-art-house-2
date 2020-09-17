class AddPhotoToLesson < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :photo, :string
  end
end
