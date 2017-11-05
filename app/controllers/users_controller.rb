class UsersController < ApplicationController
  before_action :search_user, only: [:show, :edit, :update]
  before_action :logged_in_user, only: [:edit, :update]
  before_action :currect_user && :admin, only: [:edit, :update, :destroy]

  def show

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash.now[:success]= "Welcome #{@user.name}"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit

  end

  def update

    if @user.update_attributes(user_params)
      flash[:success] = "Profile update"
      redirect_to @user
    else
      render 'edit'
      flash[:info] = 'Opps, problems'
    end
  end

  def destoy
    User.find(params[:id]).destroy
    flash[:success] = "User destroy"
    redirect_to root_url
  end

  private

  def search_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in"
      redirect_to root_url
    end
  end

  def currect_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user = current_user?(@user)
  end
end
