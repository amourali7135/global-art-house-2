class AddActiveToJobs < ActiveRecord::Migration[6.0]
  def change
      add_column :jobs, :active, :boolean
  end
end
