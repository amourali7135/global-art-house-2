class ArtistsController < ApplicationController

  def index
    @artists = Artist.all
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(params[:id])
    user = current_user
    if @artist.save
      redirect_to dashboard_path
    else
      render "new"
    end
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])
    if @artist.update(artist_params)
      redirect_to @artist
    else
      render 'edit'
    end
  end

  def delete
    @artist = Artist.find(params[:id])
    @artist.destroy
    redirect_to root_path
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def artist_params
    params.require(:artist).permit( :first_name, :last_name, :email, :photo, :artist_name, :photo, :bio, :age, :languages_spoken, :instagram, :facebook, :website, :birth_place, :city, :country, :longitude, :latitude)
  end
end
