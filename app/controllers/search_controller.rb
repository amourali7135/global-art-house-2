class SearchController < ApplicationController
  def index
    if params[:query].present?
      arts = Art.search(params[:query]) && artists = Artist.search(params[:query])
      #  else
      # @gifts = Gift.all
    end
  end
end

