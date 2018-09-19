class BoughtSkinsController < ApplicationController
  include BoughtSkinsHelper
  def create
    @skin = Skin.find_by(id: params[:skin_id])
    b = BoughtSkin.create(user_id: current_user.id,
                      name: @skin.name,
                      skin_type: @skin.skin_type,
                      selected: false,
                      image: @skin.image)
            
    redirect_to inventory_path
  end

  def index
    @skins = nil
    @choice = params[:choice]
    if params[:choice]
      @skins = current_user.bought_skins.where(skin_type: params[:choice])
    else
      @skins = current_user.bought_skins
    end

    @checked = params[:checked]
    @skin_id = params[:skin_id]
    @skin = BoughtSkin.find_by(id: params[:skin_id])
    update_selected_skins(@skin, @checked)

    respond_to do |format|
      format.html
      format.js
    end
  end
end
