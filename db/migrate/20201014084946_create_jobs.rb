class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.text :requirements
      t.string :salary
      t.string :photo
      t.boolean :remote
      t.string :city
      t.string :country
      t.float :latitude
      t.float :longitude
      t.string :company
      t.string :seniority
      t.string :industry
      t.text :benefits
      t.text :why
      t.string :frequency
      t.text :preferred
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
