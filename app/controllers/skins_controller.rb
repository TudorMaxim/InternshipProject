class SkinsController < ApplicationController
  before_action :check_admin, only: [:create]

  def create
    @skin = Skin.create(skin_params)
    if @skin.save
      flash[:notice] = "New skin successfully added!"
    else
      flash[:danger] = "Invalid skin!"
    end
    redirect_to skins_path
  end

  def index
    @skin = Skin.new
    @skins = nil
    @type = nil
    if params[:choice]
      @skins = Skin.where(skin_type: params[:choice]).paginate(page: params[:page], per_page: 6)
      @type = params[:choice]
    else
      @skins = Skin.paginate(page: params[:page], per_page: 6)
      @type = "all"
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def check_admin
    return current_user.admin?
  end

  def skin_params
    params.require(:skin).permit(:name, :skin_type, :price, :image)
  end
end
