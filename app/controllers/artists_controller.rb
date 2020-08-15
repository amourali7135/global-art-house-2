class ArtistsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :countries ]

  def index
    if params["search"] #reject '' in middle added 112619
      @filter = params["search"]["tag_list"].concat([params['country']]).concat([params["search"]["city"]]).concat([params["search"]["country"]]).flatten.reject(&:blank?)
      @artists = Artist.global_search(@filter).includes([:arts]).includes([:taggings]).paginate(page: params[:page], per_page: 15)

    else #112619 I added this while trying to get sort to work.
      @artists = Artist.includes([:arts]).includes([:taggings]).paginate(page: params[:page], per_page: 16)

    end
    #params[:search][:sorted_by] == "" by default...
    # if params[:search] && params[:search][:sorted_by] #first part added experimental, not originally.
    if params[:search] && params[:search][:sorted_by] && params[:search][:sorted_by] != ''
      if params[:search][:sorted_by] == 'most_likes'
        # @artists = Artist.global_search(@filter).sort_by { |artist| -artist.get_likes.size }
        @artists = @artists.sort_by { |artist| -artist.get_likes.size }
        # @artists.order('get_likes.size DESC')
        #paginate here
      end
      if params[:search][:sorted_by] == 'most_viewed'
        # @artists = Artist.global_search(@filter).sort_by { |artist| -artist.hits }
        @artists = @artists.sort_by { |artist| -artist.hits }
        #paginate here
      end
      if params[:search][:sorted_by] == 'most_recent'
        # @artists = Artist.global_search(@filter).sort_by { |artist| -artist.id }
        @artists = @artists.sort_by { |artist| -artist.id }
        #paginate here
      end
      if params[:search][:sorted_by] == 'most_followed'
        # @artists = Artist.global_search(@filter).sort_by { |artist| -artist.id }
        @artists = @artists.sort_by { |artist| -artist.followers_count }
        #paginate here
      end
      #paginate here
    end
  end

  def new
    @category = ['Painting', 'Drawing', 'Sculpting', 'Architecture', 'Ceramics', 'Electronic', 'Light', 'Graphic', 'Photography', 'Textile', 'Performance', 'Poetry', 'Literature', 'Collage', 'Digital', 'Animation', 'Body', 'Street', 'Graffiti', 'Glass', 'Tapestry', 'Installation', 'Calligraphy', 'Dance', '' ].sort
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    @artist.user_id = current_user.id
    if @artist.save
      flash[:notice] = "Your artist profile was successfully created!"
      redirect_to dashboard_path
    else
      render "new"
    end

  end

  def show
    @user = current_user
    @artist = Artist.friendly.find(params[:id])
    @conversation = Conversation.find_by(author: @user, receiver: @artist)
    @artist.punch(request)
  end

  def update
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
      @artists = Artist.where(country: params[:country][:country]).paginate(page: params[:page], per_page: 16)
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

end



