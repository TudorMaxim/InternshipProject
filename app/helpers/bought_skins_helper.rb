module BoughtSkinsHelper
  def update_selected_skins(skin, checked)
    if skin
      if checked == 'true'
        current_selected_skin = current_user.selected_bought_skins.find_by(skin_type: skin.skin_type)
        skin.update_attributes(selected: true)
        if current_selected_skin
          current_selected_skin.update_attributes(selected: false)
        end
      else
        skin.update_attributes(selected: false)
        default_skin = BoughtSkin.where("skin_type = ? AND name LIKE ?", skin.skin_type, "%default%").first
        default_skin.update_attributes(selected: true)
      end
    end
  end
end
