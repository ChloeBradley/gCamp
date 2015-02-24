class CreateProjectTable < ActiveRecord::Migration
  def change
    create_table :project_tables do |t|
      t.string :name
    end
  end
end
