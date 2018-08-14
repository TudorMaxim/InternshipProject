module LeaderboardsHelper

  def all_time_leaderboard
    best_all_time = User.all.sort { |a, b| b.victories <=> a.victories }
    my_position = nil
    if user_signed_in?
      my_position = best_all_time.find_index(current_user)
    end
    if best_all_time.count > 10
      best_all_time = best_all_time[0..9]
    end
    return best_all_time, my_position
  end

  def monthly_leaderboard
    best_monthly = User.all.sort { |a, b| monthly_victories(b) <=> monthly_victories(a) }
    my_position = nil
    if user_signed_in?
      my_position = best_monthly.find_index(current_user)
    end
    if best_monthly.count > 10
      best_monthly = best_monthly[0..9]
    end
    return best_monthly, my_position
  end

  def daily_leaderboard
    best_daily = User.all.sort { |a, b| daily_victories(b) <=> daily_victories(a) }
    my_position = nil
    if user_signed_in?
      my_position = best_daily.find_index(current_user)
    end
    if best_daily.count > 10
      best_daily = best_daily[0..9]
    end
    return best_daily, my_position
  end

  def all_time_victories(user)
    return user.victories
  end

  def monthly_victories(user)
    games = user.played_games.select {|game| game.finished_at > 1.month.ago }
    #games = user.played_games.where('finished_at > ?', 1.month.ago)
    return get_victories(user, games)
  end

  def daily_victories(user)
    games = user.played_games.select {|game| game.finished_at > 1.day.ago }
    #games = user.played_games.where() {|game| game.finished_at > 1.day.ago }
    return get_victories(user, games)
  end

  def all_time_favorite_hand(user)
    return get_favorite_hand(user, user.played_games)
  end

  def monthly_favorite_hand(user)
    games = user.played_games.select {|game| game.finished_at > 1.month.ago }
    return get_favorite_hand(user, games)
  end

  def daily_favorite_hand(user)
    games = user.played_games.select {|game| game.finished_at > 1.day.ago }
    return get_favorite_hand(user, games)
  end

  def get_favorite_hand(user, games)
    rock = 0
    paper = 0;
    scissors = 0;
    games.each do |game|
      if game.sender_id == user.id
        if game.sender_choice == "rock"
          rock = rock + 1
        elsif game.sender_choice == "paper"
          paper = paper + 1
        else
          scissors = scissors + 1
        end
      else
        if game.receiver_choice == "rock"
          rock = rock + 1
        elsif game.receiver_choice == "paper"
          paper = paper + 1
        else
          scissors = scissors + 1
        end
      end
    end
    return "rock" if [rock, paper, scissors].max == rock
    return "paper" if [rock, paper, scissors].max == paper
    return "scissors"
  end

  def get_victories(user, games)
    return games.select {|game| game.winner_id == user.id}.count
  end
end
