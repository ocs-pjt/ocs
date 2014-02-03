class ChangeJobIdTypeToInProgressTask < ActiveRecord::Migration
  def self.up
   change_column :in_progress_tasks, :job_id, :string
  end
end
