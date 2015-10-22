class TaskController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @undone_tasks = Task.undone
    @done_tasks = Task.done
  end

  def show
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to task_index_url }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { redirect_to task_index_url, alert: @task.errors.full_messages.first }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_index_url }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { redirect_to edit_task_path, alert: @task.errors.full_messages.first }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to task_index_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      if params[:task].present? && params[:task].is_a?(String)
        task_text = params[:task]
        params[:task] = {
          task: task_text,
          done: params[:done]
        }
      end
      params.require(:task).permit(:task, :done)
    end
end
