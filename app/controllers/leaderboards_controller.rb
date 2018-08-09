class LeaderboardsController < ApplicationController
  include LeaderboardsHelper

  def index
    @best = nil
    @my_position = nil
    @type = params[:choice]
    @rank = 0

    if params[:choice] == "all_time"
      @best, @my_position = all_time_leaderboard()
    elsif params[:choice] == "monthly"
      @best, @my_position = monthly_leaderboard()
    else
      @best, @my_position = daily_leaderboard()
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

end
