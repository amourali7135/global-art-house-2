class ArtistsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @artists = Artist.all
  end

  def new
    # @user = User.find(params[:user_id])
    @category = ['Painting', 'Drawing', 'Sculpting', 'Architecture', 'Ceramics', 'Electronic', 'Light', 'Graphic', 'Photography', 'Textile', 'Performance', 'Poetry', 'Literature', 'Collage', 'Digital', 'Animation', 'Body', 'Street', 'Graffiti', 'Glass', 'Tapestry', 'Installation', 'Calligraphy', 'Dance', '' ].sort
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    @artist.user_id = current_user.id
    if @artist.save
      redirect_to dashboard_path
    else
      render "new"
    end
  end

  def show
    # @user = User.find(params[:user_id])
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
    @category = ['Painting', 'Drawing', 'Sculpting', 'Architecture', 'Ceramics', 'Electronic', 'Light', 'Graphic', 'Photography', 'Textile', 'Performance', 'Poetry', 'Literature', 'Collage', 'Digital', 'Animation', 'Body', 'Street', 'Graffiti', 'Glass', 'Tapestry', 'Installation', 'Calligraphy', 'Dance', '' ].sort
    @artist = Artist.find(params[:id])
  end

  def like
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @artist = Artist.find(params[:id])
    @artist.liked_by @user
    redirect_to @artist, notice: "Liked this artist successfully!"
  end

  def unlike
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @artist = Artist.find(params[:id])
    @artist.unliked_by @user
    redirect_to @artist, notice: "Unliked this artist successfully!"
  end

  def follow
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @artist = Artist.find(params[:id])
    @user.follow(@artist)
    redirect_to @artist, notice: "Followed this artist successfully!"
  end

  def unfollow
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @artist = Artist.find(params[:id])
    @user.stop_following(@artist)
    redirect_to @artist, notice: "Unfollowed this artist successfully!"
  end

  def followers  #Do conditional to show artist name if is an artist.
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @artist = Artist.find(params[:id])
    @artist.followers(User)
  end

  def countries
    if params[:country]
      @artists = Artist.where(country: params[:country][:country])
    else
      @artists = Artist.where(country: "US")
    end

  end

  private

  def artist_params
    params.require(:artist).permit( :first_name, :last_name, :photo, :artist_name, :photo, :bio, :age, :languages_spoken, :instagram, :facebook, :website, :birth_place, :city, :country, :longitude, :latitude, :form, form: [], tag_list: [])
  end

  # def country_params
  #   params.require(:country).permit( :country, params[:country] )
  # end
end
