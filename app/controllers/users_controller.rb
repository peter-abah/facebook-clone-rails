class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    d = params[:date]
    date = Date.new(1, d[:month].to_i, d[:day].to_i)

    if @user.update(user_params) && @user.update(birthday: date)
      redirect_to @user
    else
      render :edit
    end
  end

  def friends
    @friends = current_user.friends
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :bio, :current_city, :profile_picture, :cover_image)
    end

    def set_user
      @user = current_user
    end
end
