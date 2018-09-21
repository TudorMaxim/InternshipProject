class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :logged_in_user, only: [:index, :edit, :update, :show]
  before_action :correct_user,   only: [:edit, :update]

  def show
    @user = User.find_by(id: params[:id])
  end

  def index
    @users = User.search(params[:search]).paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    if @user.destroy
        redirect_to root_url, notice: "User banned successfully!"
    end
  end

  private
  def logged_in_user
    unless user_signed_in?
      flash[:alert] = "Please log in."
      redirect_to user_session_url
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to(root_url) unless @user == current_user
  end

end
