class ArtistsController < ApplicationController

  def index
    # @user = User.find(params[:user_id])

    @artists = params[:tag] ? Artist.tagged_with(params[:tag]) : Artist.all

    if params["search"]
      @filter = params["search"]["tag_ids"].concat([params['country']]).concat([params["search"]["city"]]).concat([params["search"]["country"]]).flatten.reject(&:blank?)
      @artists = Artist.global_search(@filter)
    else
      @artists = Artist.all
    end
    # respond_to do |format|
    #   format.html
    #   format.js
    # end
  end

  def new
    # @user = User.find(params[:user_id])
    @category = ['Painting', 'Drawing', 'Sculpting', 'Architecture', 'Ceramics', 'Electronic', 'Light', 'Graphic', 'Photography', 'Textile', 'Performance', 'Poetry', 'Literature', 'Collage', 'Digital', 'Animation', 'Body', 'Street', 'Graffiti', 'Glass', 'Tapestry', 'Installation', 'Calligraphy', 'Dance', '' ].sort
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    @artist.user_id = current_user.id
    byebug
    create_tags(@artist)
    if @artist.save
      redirect_to dashboard_path
    else
      render "new"
    end

  end

  def show
    @user = current_user
    # @user = User.find(params[:user_id])
    @artist = Artist.find(params[:id])
    @conversation = Conversation.find_by(author: @user, receiver: @artist)
    @artist.punch(request)
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
    params.require(:artist).permit( :first_name, :last_name, :photo, :artist_name, :photo, :bio, :age, :languages_spoken, :instagram, :facebook, :website, :birth_place, :city, :country, :longitude, :latitude, :user, :user_id, :form, form: [], tag_list: [] )
  end

  def country_params
    params.require(:country).permit( :country, params[:country], params[:country][:country] )
  end

  def create_tags(artist)
    tags = params.dig(:artist, :tag_ids) || []
    tags.reject { |tag| tag == '' }.each do |tag|
      tag_p = Tag.find_by(name: tag) || Tag.create(name: tag)
      ArtistTag.create!(artist: artist, tag: tag_p)
    end
  end

end
