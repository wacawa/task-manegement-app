class TasksController < ApplicationController
  before_action :set_user#, only: [:new, :create, :index, :show, :edit]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  before_action :correct_user

  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = 'タスクを作成しました。'
      redirect_to user_task_url(@user, @task)
    else
      render :new
    end
  end

  def index
    @tasks = Task.where(user_id: params[:user_id]).order(id: "DESC")
  end
  
  def show
  end

  def edit
  end
  
  def update
    if @task.update_attributes(task_params)
      flash[:success] = 'タスクを作成しました。'
      redirect_to user_task_url(@task)
    else
      flash[:danger] = 'タスクの更新に失敗しました。'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    redirect_to user_tasks_url
  end

  private
  
    def task_params
      params.require(:task).permit(:title, :content).merge(user_id: params[:user_id])
    end
  

    #beforeアクション
    
    def set_user
       @user = User.find(params[:user_id])
    end
  
    def set_task
       @task = Task.find(params[:id])
    end
      
end
