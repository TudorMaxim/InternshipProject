module ChallengesHelper
  def find_challenge(challenge_id)
    c = current_user.challenges.find_by(id: challenge_id)
    if c.nil?
      c = current_user.inverse_challenges.find_by(id: challenge_id)
    end
    return c
  end
end
