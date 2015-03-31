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
    if @user.destroy
      redirect_to sign_in_path
    end
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
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def verify_user_access
   unless current_user == @user
     render file: 'public/404.html', status: :not_found, layout: false
   end
 end
end
