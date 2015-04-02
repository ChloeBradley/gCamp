class UsersController < ApplicationController
before_action :authenticate_user
before_action :set_user, except: [:index, :new, :create]
before_action :verify_user_access, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end


  def show
  end

  def edit
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User was successfully created!"
       redirect_to users_path
    else
      render:new
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User was successfully updated!"
      redirect_to users_path
    else
      render :edit
    end
  end

  def new
    @user = User.new
  end

  private

  def user_params
    if current_user.admin
       params.require(:user).permit(:first_name, :last_name, :email, :password, :tracker_token, :password_confirmation, :admin)
     else
       params.require(:user).permit(:first_name, :last_name, :email, :password, :tracker_token, :password_confirmation)
     end
   end

  def set_user
    @user = User.find(params[:id])
  end

  def verify_user_access
    raise AccessDenied unless current_user == @user || current_user.admin?
  end
end
