json.array! @notifications do |notification|
  json.id notification.id
  json.actor notification.actor.full_name
  json.actor_link user_path(id: notification.actor.id)
  json.image gravatar_for(notification.actor, size: 20)
  json.action notification.action
  if notification.notifiable_type == "Friendship"
    json.url friendship_path(id: notification.notifiable_id)
  else
    json.url challenge_path(id: notification.notifiable_id)
  end
end
