class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def friends
    @friends = current_user.friends
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end
