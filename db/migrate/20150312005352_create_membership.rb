class CreateMembership < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.string :role
      t.integer :project_id
      t.integer :user_id

      t.timestamps
    end
  end
end
