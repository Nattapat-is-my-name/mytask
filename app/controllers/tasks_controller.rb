class TasksController < ApplicationController
  before_action :set_task, only: %i[update destroy confirm_delete]

  def index
    @tasks = Task.all.sort_by do |task|
      if task.completed?
        [ 4, task.due_time || Time.current ]  # Completed tasks last
      elsif task.due_time.nil?
        [ 3, 1.year.from_now ]  # Tasks with no due date
      else
        time_diff = task.due_time - Time.current

        if time_diff > 0
          # Future tasks - closer to due date = higher priority (lower number)
          [ 1, time_diff ]  # Due soon tasks first (sorted by time remaining)
        else
          # Overdue tasks - more overdue = lower priority (higher number)
          [ 2, time_diff.abs ]  # Overdue tasks second (sorted by how overdue)
        end
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path, notice: "Task was successfully created." }
        format.json { render json: { status: "created" }, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        # Check if request came from index page (checkbox toggle)
        if request.referer&.include?(tasks_path) || params[:task][:from_index] == "true"
          format.html { redirect_to tasks_path }
        else
          format.html { redirect_to tasks_path, notice: "Task was successfully updated." }
        end
        format.turbo_stream { render turbo_stream: turbo_stream.replace("task_#{@task.id}", partial: "task_card", locals: { task: @task }) }
        format.json { render json: { status: "ok" }, status: :ok }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @task.destroy
      respond_to do |format|
        format.html { redirect_to tasks_path, status: :see_other, notice: "Task was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      redirect_to tasks_path, alert: "Failed to delete task."
    end
  end

  def confirm_delete
    # Renders confirm_delete.html.erb
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :due_time, :completed)
  end
end
