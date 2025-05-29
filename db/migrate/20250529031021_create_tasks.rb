class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.datetime :due_time
      t.string :status

      t.timestamps
    end
  end
end
