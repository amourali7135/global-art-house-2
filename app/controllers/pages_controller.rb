class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :browse, :about, :help, :contact ]
  include Pagy::Backend

  def home
    @artists = Artist.all
    @arts = Art.all
    if current_user
      @user = current_user
      @artist = Artist.find_by(user_id: @user.id) #user_id: refers to artist table one!
      # @artist = Artist.find(params[:id])
      # redirect_to dashboard_path
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
  if !@user.artist
    redirect_to root_path
  end
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
    @pagy, @artists = pagy(Artist.global_search(@filter), page: params[:page], items: 20)
    @pagy, @arts = pagy(Art.global_search(@filter), page: params[:page], items: 20)
  elsif params[:tag]
    @filter = params[:tag]
    @artists = Artist.global_search(@filter)
    @arts = Art.global_search(@filter)
    @pagy, @artists = pagy(Artist.global_search(@filter), page: params[:page], items: 20)
    @pagy, @arts = pagy(Art.global_search(@filter), page: params[:page], items: 20)
  else
    @artists = Artist.all
    @arts = Art.all
    @pagy, @artists = pagy(Artist.all, page: params[:page], items: 20)
    @pagy, @arts = pagy(Art.all, page: params[:page], items: 20)
  end
end

def following
  @user = current_user
  # @user.all_following.each do |followed|
  # followed.arts.sort_by { |art| art.created_at }.each do |art|
  pagy = Pagy.new(count: 5, items: 5)
  @pagy, @arts = pagy(pagy_get_items(current_user.all_following, pagy), page: params[:page], items: 5)
  # raise
  # end
# end
  # @arts = Art.all.order("created_at DESC")
  # @artist = Artist.all
  # @arts = Art.all
end

def followers
  @user = current_user
  @artist = Artist.find_by(user_id: @user.id)
end

private

  def pagy_get_items(array, pagy)
    array[pagy.offset, pagy.items]
  end


end
