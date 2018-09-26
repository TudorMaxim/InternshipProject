class LeaderboardsController < ApplicationController
  authorize_resource class: :leaderboard
  include LeaderboardsHelper

  def index
    @best = nil
    @my_position = nil
    @type = params[:choice]
    @rank = 0

    if params[:choice] == "daily"
      @best, @my_position = daily_leaderboard()
    elsif params[:choice] == "monthly"
      @best, @my_position = monthly_leaderboard()
    else
      @best, @my_position = all_time_leaderboard()
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

end
