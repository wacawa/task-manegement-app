class TasksController < ApplicationController
  before_action :set_user, only: [:new, :create, :index, :show, :edit]

  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new()
    if @task.valid?
      @task.save
      flash[:success] = 'タスクを作成しました。'
      redirect_to user_tasks_url
    else
      flash[:danger] = '作成できませんでした。'
      render :new
    end
  end
    
  def index
    @tasks = Task.all
  end
  
  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = 'タスクを更新しました。'
      redirect_to user_task_url(@task)
    else
      flash[:danger] = 'タスクの更新に失敗しました。'
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to user_tasks_url
  end

  
  def set_user
     @user = User.find(params[:user_id])
  end
  
  private
  
    def task_params
      params.require(:task).permit(:title, :content).merge(user_id: params[:user_id])
    end
  

end
