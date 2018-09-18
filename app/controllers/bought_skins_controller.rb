class BoughtSkinsController < ApplicationController
  def create
    @skin = Skin.find_by(id: params[:skin_id])

    BoughtSkin.create(user_id: current_user.id,
                      name: @skin.name,
                      skin_type: @skin.skin_type,
                      selected: false,
                      image: @skin.image)

    redirect_to inventory_path

  end

  def index
    @skins = nil
    if params[:choice] == "selected"
      @skins = current_user.bought_skins.where(selected: true).paginate(page: params[:page], per_page: 6)
    elsif params[:choice]
      @skins = current_user.bought_skins.where(skin_type: params[:choice]).paginate(page: params[:page], per_page: 6)
    else
      @skins = current_user.bought_skins.paginate(page: params[:page], per_page: 6)
    end
    respond_to do |format|
      format.html
      format.js
    end
  end
end
