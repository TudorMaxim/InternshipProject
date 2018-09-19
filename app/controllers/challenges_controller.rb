class ChallengesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:show, :update]
  include ChallengesHelper

  def create
    u = User.find_by(id: params[:receiver_id])
    if current_user.challenge(u)
      flash[:notice] = "You have succesfully challenged " + u.full_name + "!"
      redirect_to root_url
    else
      flash[:danger] = "Unable to challenge " + u.full_name + "!"
      redirect_to root_url
    end
  end

  def update
    @challenge = find_challenge(params[:id])
    u = User.find_by(id: @challenge.sender_id)
    if current_user.accept_challenge(u)
      #flash[:notice] = "Challenge accepted! Good luck!"
      redirect_to challenge_url(@challenge)
    else
      flash[:danger] = "Unable to accept challenge from " + u.full_name + "!"
      redirect_to root_url
    end
  end

  def destroy
    @challenge = find_challenge(params[:id])
    Notification.find_by(notifiable_id: @challenge.id, notifiable: @challenge, action: "challenged you!").read
    @challenge.destroy
    flash[:notice] = "Challenge declined!"
    redirect_to root_url
  end

  def index
    @challenges = current_user.played_games.paginate(page: params[:page])
  end

  def show
    @challenge = Challenge.find_by(id: params[:id])
    notification = Notification.find_by(action: "accepted your challenge!", notifiable: @challenge)
    if notification.recipient == current_user
      Notification.find_by(action: "accepted your challenge!", notifiable: @challenge).read
    end
    @me = current_user
    @emeny = nil
    if params[:choice]
      @challenge.make_choice(current_user, params[:choice])
    end
    @choices = Hash.new
    if @challenge.sender_id == current_user.id
      @enemy = User.find_by(id: @challenge.receiver_id)
      @choices[@me] = @challenge.sender_choice
      @choices[@enemy] = @challenge.receiver_choice
    else
      @enemy = User.find_by(id: @challenge.sender_id)
      @choices[@me] = @challenge.receiver_choice
      @choices[@enemy] = @challenge.sender_choice
    end

    @my_skin = current_user.selected_bought_skins.find_by(skin_type: @choices[@me])
    @enemy_skin = @enemy.selected_bought_skins.find_by(skin_type: @choices[@enemy])
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def correct_user
    @challenge = Challenge.find_by(id: params[:id])
    @sender = User.find_by(id: @challenge.sender_id)
    @receiver = User.find_by(id: @challenge.receiver_id)
    redirect_to root_url unless @sender == current_user || @receiver == current_user
  end
end
