class CreateComment < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.integer :user_id
      t.integer :task_id

      t.timestamps
    end
  end
end
