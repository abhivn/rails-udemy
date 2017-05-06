class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new

  end

  def create
    @user = User.new(users_params)
    if @user.save
      flash[:success] = "Welcome to the alpha blog #{@user.username}"
      redirect_to articles_path
  else
    render 'new'
  end
end

def edit
  @user = User.find(params[:id])
end

def update
  @user = User.find(params[:id])
  if @user.update(users_params)
    flash[:success] = "Your account was successfully updated.."
    redirect_to articles_path
  else
    render 'edit'
  end

end

def show
  @user = User.find(params[:id])

end

  private
  def users_params
    params.require(:user).permit(:username,:password,:email)
  end
end
