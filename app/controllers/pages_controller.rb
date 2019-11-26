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

    @artists = Artist.geocoded #returns artists with coordinates, BRO THIS LINE MAKES ARTISTS WITH GEO SHOW ONLY ON THE HOME PAGE!
    #FUCK!

    @markers = @artists.map do |artist|
      {
        lat: artist.latitude,
        lng: artist.longitude,
        infoWindow: render_to_string(partial: "artists/info_window", locals: { artist: artist })
      }
    end
  end

  def dashboard
    @user = current_user
    @artist = Artist.find_by(user_id: @user.id) #user_id: refers to artist table one!
    if !@user.artist
      flash[:notice] = "Only users with artist profiles have dashboards!"
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
    elsif params[:tag_id]
      @filter = params[:tag_id]
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

    if params[:search]
      if params[:search][:sorted_by] === 'most_comments' #Have to do it this way since it's nested in search!!!
        # @arts = Art.global_search(@filter).sort_by { |art| -art.comments.count }
        @arts = @arts.sort_by { |art| -art.comments.count }
        @pagy, @artists = pagy(@artists, page: params[:page], items: 20)
        @pagy, @arts = pagy(@arts, page: params[:page], items: 20)
      end
      if params[:search][:sorted_by] === 'most_likes'
        # @arts = Art.global_search(@filter).sort_by { |art| -art.get_likes.size }
        @arts = @arts.sort_by { |art| -art.get_likes.size }
        @pagy, @artists = pagy(@artists, page: params[:page], items: 20)
        @pagy, @arts = pagy(@arts, page: params[:page], items: 20)
      end
      if params[:search][:sorted_by] === 'most_viewed'
        # @arts = Art.global_search(@filter).sort_by { |art| -art.hits }
        @arts = @arts.sort_by { |art| -art.hits }
        @pagy, @artists = pagy(@artists, page: params[:page], items: 20)
        @pagy, @arts = pagy(@arts, page: params[:page], items: 20)
      end
      if params[:search][:sorted_by] === 'most_recent'
        # @arts = Art.global_search(@filter).sort_by { |art| -art.id }
        @arts = @arts.sort_by { |art| -art.id }
        @pagy, @artists = pagy(@artists, page: params[:page], items: 20)
        @pagy, @arts = pagy(@arts, page: params[:page], items: 20)
      end
    end
raise
  end

  def following
    @user = current_user
    @art_array = []
    @user.all_following.sort_by { |followed| followed }.each do |following|
      following.arts.map { |art| @art_array << art }
    end
    # @user.all_following.each do |followed|
    # followed.arts.sort_by { |art| art.created_at }.each do |art|
    # pagy = Pagy.new(count: 5, items: 5)
    # @pagy, @arts = pagy(pagy_get_items(@art_array, pagy), pagy, page: params[:page], items: 5)
    # @pagy, @arts = pagy(pagy_get_items(current_user.all_following, pagy), page: params[:page], items: 5)
    # raise
    # end
    # end
    # @arts = Art.all.order("created_at DESC")
    # @artist = Artist.all
    # @arts = Art.all
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
    @artists = @user.find_liked_items.map { |item| item.is_a?(Artist) ? item : nil }.compact
    @arts = @user.find_liked_items.map { |item| item.is_a?(Art) ? item : nil }.compact

    # if @user.find_liked_items.length > 20
    #   @many_liked = true
    #   @user.find_liked_items = @user.find_liked_items[-20..-1]
    # end

    # if params[:m]
    #   @many_liked = false
    #   @user.find_liked_items
    #   end
    #   @user.find_liked_items
    # end


  end

  private

  def pagy_get_items(array, pagy)
    array[pagy.offset, pagy.items]
  end


end

