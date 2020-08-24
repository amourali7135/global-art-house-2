class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :browse, :about, :help, :contact, :career, :team, :updates ]


  def home
    # @artists = Artist.all
    @arts = Art.includes([:artist]).includes([:taggings])
    if current_user
      @user = current_user
      @artist = Artist.find_by(user_id: @user.id) #user_id: refers to artist table one!
      # @artist = Artist.find(params[:id])
      # redirect_to dashboard_path
    end

    #When you launch, limit this line so it doesn't query the whole fucking DB.
    @artists = Artist.geocoded.includes([:taggings]) #.sample(15) #returns artists with coordinates, BRO THIS LINE MAKES ARTISTS WITH GEO SHOW ONLY ON THE HOME PAGE!
    #FUCK!


    @markers = @artists.includes([:arts]).map do |artist|
      {
        lat: artist.latitude,
        lng: artist.longitude,
        infoWindow: render_to_string(partial: "artists/info_window", locals: { artist: artist })
      }
    end
  end

  def dashboard
    @user = current_user
    if !@user.artist
      flash[:notice] = "Only users with artist profiles have dashboards!"
      redirect_to root_path
    end
    @artist = Artist.find_by(user_id: @user.id) #user_id: refers to artist table one!
    @art = Art.find_by(artist_id: @artist.id)
    @article = Article.find_by(artist_id: @artist.id)
    # @art = Art.where(artist_id: @artist.id)

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

  def career

  end

  def team

  end

  def updates

  end

  def blog

  end

  def browse
    if params["search"]
      @filter = params["search"]["tag_list"].concat([params["search"]["city"]]).concat([params["search"]["country"]]).flatten.reject(&:blank?)
      @artists = Artist.global_search(@filter)
      @arts = Art.global_search(@filter).includes([:artist]).includes([:taggings]).paginate(page: params[:page], per_page: 15)
      # pagination here
      # pagination here

    else
      # @artists = Artist.all
      @arts = Art.includes([:artist]).includes([:taggings]).paginate(page: params[:page], per_page: 15)
      # pagination here
      # pagination here
    end

    if params[:search] && params[:search][:sorted_by]
      if params[:search][:sorted_by] == 'most_comments' #Have to do it this way since it's nested in search!!!
        # @arts = Art.global_search(@filter).sort_by { |art| -art.comments.count }
        @arts = @arts.sort_by { |art| -art.comments.count }
        # pagination here
        # pagination here
      end
      if params[:search][:sorted_by] == 'most_likes'
        # @arts = Art.global_search(@filter).sort_by { |art| -art.get_likes.size }
        @arts = @arts.sort_by { |art| -art.get_likes.size }
        # pagination here
        # pagination here
      end
      if params[:search][:sorted_by] == 'most_viewed'
        # @arts = Art.global_search(@filter).sort_by { |art| -art.hits }
        @arts = @arts.sort_by { |art| -art.hits }
        # pagination here
        # pagination here
      end
      if params[:search][:sorted_by] == 'most_recent'
        # @arts = Art.global_search(@filter).sort_by { |art| -art.id }
        @arts = @arts.sort_by { |art| -art.id }
        # pagination here
        # pagination here
      end
    end

  end

  def following
    @user = current_user
    @art_array = []
    @user.all_following.sort_by { |followed| followed }.each do |following|
      following.arts.map { |art| @art_array << art }
    end

    if @art_array.length > 15
      @many_following = true
      @art_array = @art_array[-15..-1]
    end

    if params[:m]
      @many_following = false
      @user.all_following.sort_by { |followed| followed }.each do |following|
        following.arts.map { |art| @art_array << art }
      end
      @art_array
    end

  end

  def followers
    @user = current_user
    @artist = Artist.find_by(user_id: @user.id)
  end

  def liked
    @user = current_user
    @artists = @user.find_liked_items.map { |item| item.is_a?(Artist) ? item : nil }.compact.paginate(page: params[:page], per_page: 15)
    @arts = @user.find_liked_items.map { |item| item.is_a?(Art) ? item : nil }.compact.paginate(page: params[:page], per_page: 15)

  end

  private

  # def pagy_get_items(array, pagy)
  #   array[pagy.offset, pagy.items]
  # end


end

