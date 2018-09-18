module SkinsHelper

  def free_skin (s)
    return s.price == 0
  end

  def owned_skin (s)
    skin = current_user.bought_skins.find_by(name: s.name)
    return !skin.nil?
  end
  
end
