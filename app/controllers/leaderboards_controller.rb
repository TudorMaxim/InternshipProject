class LeaderboardsController < ApplicationController
  def index
    @best_all_time = User.all.sort { |a, b| b.victories <=> a.victories }
    @my_position = nil
    if user_signed_in?
      @my_position = @best_all_time.find_index(current_user)
    end
    if @best_all_time.count > 10
      @best_all_time = @best_all_time[0..9]
    end
  end
end
