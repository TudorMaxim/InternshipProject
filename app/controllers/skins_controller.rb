class SkinsController < ApplicationController
  def index
    @skins = Skin.paginate(page: params[:page])
  end
end
