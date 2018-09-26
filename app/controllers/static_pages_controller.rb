class StaticPagesController < ApplicationController
  authorize_resource class: :static_pages
  def home
  end

  def help
  end

  def about
  end

  def contact
  end
end
