class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  
  def home
    @arts = Art.all.sample(3)
    if current_user
      @user = current_user
      @artist = Artist.find_by(user_id: @user.id) #user_id: refers to artist table one!
      # @artist = Artist.find(params[:id])
    end
    @artists = Artist.geocoded #returns flats with coordinates
    
    @markers = @artists.map do |artist|
      {
      lat: artist.latitude,
      lng: artist.longitude
    }
  end
end

def dashboard
  @user = current_user
  @artist = Artist.find_by(user_id: @user.id) #user_id: refers to artist table one!
end

def city
  
end

def about
  
end

def explore
  
end

def help
  
end

def contact
  
end

def browse
  if params["search"]
    @filter = params["search"]["tag_ids"].reject { |tag| tag == '' }.concat([params["search"]["city"]]).concat([params["search"]["country"]]).flatten.reject(&:blank?)
    @artists = Artist.global_search(@filter)
    @arts = Art.global_search(@filter)
  else
    @artists = Artist.all
    @arts = Art.all
  end
end

def following
  @user = current_user
  # @artist = Artist.all
  # @arts = Art.all
end

private


end
