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
      flash[:notice] = "Challenge accepted! Good luck!"
      redirect_to challenge_url(@challenge)
    else
      respond_to do |format|
        format.html {
          flash[:danger] = "Unable to accept friend request from " + u.full_name + "!"
          redirect_to root_url
        }
        format.js { 'alert("it is javascript");'}
        format.json {
          @challenge.make_choice(current_user, params[:choice])
        }
      end
    end
  end

  def destroy
    @challenge = find_challenge(params[:id])
    Notification.find_by(notifiable_id: @challenge.id, notifiable: @challenge).read
    @challenge.destroy
    flash[:notice] = "Challenge declined!"
    redirect_to root_url
  end

  def index
    @challenges = current_user.played_games.paginate(page: params[:page])
  end

  def show
    @challenge = Challenge.find_by(id: params[:id])
    @me = current_user
    @emeny = nil
    if @challenge.sender_id == current_user.id
      @enemy = User.find_by(id: @challenge.receiver_id)
    else
      @enemy = User.find_by(id: @challenge.sender_id)
    end
    respond_to do |format|
      format.js
      format.html
      format.json
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
