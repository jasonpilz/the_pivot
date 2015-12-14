class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Logged in as #{@user.username}"
      redirect_to dashboard_path
    else
      # can remove the flash messages, use in view as a partial (refactor)
      flash.now[:error] = @user.errors.full_messages.join(', ')
      render :new
    end
  end

  def show
    @user = current_user
    @orders = @user.orders.last(5)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    flash.notice = "Your Account Has Been Updated!"
    redirect_to dashboard_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :bio, :image)
  end
end
