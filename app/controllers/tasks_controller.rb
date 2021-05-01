class TasksController < ApplicationController
  before_action :set_user#, only: [:new, :create, :index, :show, :edit]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  before_action :correct_user_tasks, only: :edit
  before_action :correct_user_root, except: :edit

  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = 'タスクを作成しました。'
      redirect_to user_tasks_url(@user)
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
      flash[:success] = 'タスクを更新しました。'
      redirect_to user_task_url(@user, @task)
    else
      render :edit
    end
  end
  
  def destroy
    flash[:success] = "タスクを削除しました。"
    @task.destroy
    redirect_to user_tasks_url(@user)
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
    
    def correct_user_root
      correct_user(root_url)
    end
      
    def correct_user_tasks
      correct_user(user_tasks_url(@current_user))
    end
      
end
