class ArtistsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :countries ]
  include Pagy::Backend


  def index
    # @user = User.find(params[:user_id])
    #possible problem on heroku with pagination not showing everyone...animation cheks.
    @artists = params[:tag] ? Artist.tagged_with(params[:tag]) : Artist.all

    if params["search"] #reject '' in middle added 112619
      @filter = params["search"]["tag_ids"].reject { |tag| tag == '' }.concat([params['country']]).concat([params["search"]["city"]]).concat([params["search"]["country"]]).flatten.reject(&:blank?)
      @artists = Artist.global_search(@filter)
      @pagy, @artists = pagy(Artist.global_search(@filter), page: params[:page], items: 25)
      # elsif params[:tag_id] #112619 I added this while trying to get sort to work.
      #   @filter = params[:tag_id] #112619 I added this while trying to get sort to work.
      #   @artists = Artist.global_search(@filter) #112619 I added this while trying to get sort to work.
      #   @pagy, @artists = pagy(Artist.global_search(@filter), page: params[:page], items: 4) #112619 I added this while trying to get sort to work.
    else #112619 I added this while trying to get sort to work.
      @artists = Artist.all
      @pagy, @artists = pagy(Artist.all, page: params[:page], items: 25)
    end
    # respond_to do |format|
    #   format.html
    #   format.js
    # end
    #why do I not need the paginations here at all?
    if params[:search][:sorted_by]
      if params[:search][:sorted_by] == 'most_likes'
        # @artists = Artist.global_search(@filter).sort_by { |artist| -artist.get_likes.size }
        @artists = @artists.sort_by { |artist| -artist.get_likes.size }
        # @artists.order('get_likes.size DESC')
        # @pagy, @artists = pagy(@artists, page: params[:page], items: 20)
      end
      if params[:search][:sorted_by] == 'most_viewed'
        # @artists = Artist.global_search(@filter).sort_by { |artist| -artist.hits }
        @artists = @artists.sort_by { |artist| -artist.hits }
        # @pagy, @artists = pagy(@artists, page: params[:page], items: 20) #works without this, why.
      end
      if params[:search][:sorted_by] == 'most_recent'
        # @artists = Artist.global_search(@filter).sort_by { |artist| -artist.id }
        @artists = @artists.sort_by { |artist| -artist.id }
        # @pagy, @artists = pagy(@artists, page: params[:page], items: 20)
      end
      if params[:search][:sorted_by] == 'most_followed'
        # @artists = Artist.global_search(@filter).sort_by { |artist| -artist.id }
        @artists = @artists.sort_by { |artist| -artist.followers_count }
        # @pagy, @artists = pagy(@artists, page: params[:page], items: 20)
      end
      # @pagy, @artists = pagy(@artists, page: params[:page], items: 20)
    end

  end

  def new
    # @user = User.find(params[:user_id])
    @category = ['Painting', 'Drawing', 'Sculpting', 'Architecture', 'Ceramics', 'Electronic', 'Light', 'Graphic', 'Photography', 'Textile', 'Performance', 'Poetry', 'Literature', 'Collage', 'Digital', 'Animation', 'Body', 'Street', 'Graffiti', 'Glass', 'Tapestry', 'Installation', 'Calligraphy', 'Dance', '' ].sort
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    @artist.user_id = current_user.id
    create_tags(@artist)
    if @artist.save
      flash[:notice] = "Your artist profile was successfully created!"
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
    # @artist.artist_tags.destroy_all   CONSIDER PUTTING THIS ONE BACK IN THOUGH!!!
    artist_tags = params.require(:artist).permit(tag_ids: [])[:tag_ids].reject { |tag| tag == '' }.map { |tag| Tag.find_by_name(tag) }
    artist_tags.each do |tag|
      ArtistTag.create!(artist: @artist, tag: tag)
    end
    if @artist.update(artist_params)
      flash[:notice] = "Your artist profile was successfully updated!"
      redirect_to dashboard_path
    else
      flash[:error] = "There was an error, please try again!"
      render 'edit'
    end
  end

  def delete
    @artist = Artist.find(params[:id])
    @artist.destroy
    flash[:notice] = "Your artist profile was successfully deleted!"
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
      @pagy, @artists = pagy(Artist.where(country: params[:country][:country]), page: params[:page], items: 20)
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
