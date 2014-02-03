class CreateInProgressTasks < ActiveRecord::Migration
  def change
    create_table :in_progress_tasks do |t|
      t.integer :user_id
      t.integer :job_id

      t.timestamps
    end
  end
end
