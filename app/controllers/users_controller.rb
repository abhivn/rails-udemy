class UsersController < ApplicationController

  before_action :require_same_user, only: [:edit,:update]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new

  end

  def create
    @user = User.new(users_params)
    if @user.save
      session[:user_id] = @user.id
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
  @user_articles = @user.articles.paginate(page: params[:page],per_page: 3)

end

  private
  def users_params
    params.require(:user).permit(:username,:password,:email)
  end

  def require_same_user
    if current_user != @user
      flash[:danger] = "You can only edit, update your profile"
      redirect_to root_path
    end
  end
end
