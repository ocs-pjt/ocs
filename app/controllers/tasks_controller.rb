class TasksController < ApplicationController
  before_action :authenticate_user! # Normal devise authentication
  before_action :set_task, only: [:destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks_in_progress = current_user.in_progress_tasks

    @tasks = current_user.tasks
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:user_id, :file)
    end
end
