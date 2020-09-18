class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :browse, :about, :help, :contact, :career, :team, :updates, :articles, :services, :collaborations, :blog ]


  def home
    # @artists = Artist.all
    #Heroku is giving me issues here.
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

    # def create_subscription
    #   @subscription = Subscription.new(subscription_params)
    #   if @subscription.save
    #     flash[:notice] = "You've been successfully added to our subscription list'!"
    #     redirect_to root_path
    #   else
    #     flash[:notice] = "There was an error, please try again!"
    #     redirect_to root_path
    #   end
    # end

    @subscription = Subscription.new  #(subscription_params)
    # raise
  end

  def dashboard
    if !current_user.artist
      flash[:notice] = "Only users with creator profiles have access to dashboards!"
      redirect_to root_path
    end
    @artist = Artist.find_by(user_id: current_user.id) #user_id: refers to artist table one!
    @art = Art.find_by(artist_id: @artist.id) #Do I even need these?
    @article = Article.find_by(artist_id: @artist.id) #Do I even need these?
    @service = Service.find_by(artist_id: @artist.id) #Do I even need these?
    @collaboration = Collaboration.find_by(artist_id: @artist.id) #Do I even need these?
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

  def articles
    if params["search"]
      @filter = params["search"]["tag_list"].concat([params["search"]["city"]]).concat([params["search"]["country"]]).concat([params["search"]["title"]]).concat([params["search"]["body"]]).concat([params["search"]["artist_name"]]).concat([params["search"]["first_name"]]).concat([params["search"]["last_name"]]).concat([params["search"]["bio"]]).concat([params["search"]["birth_place"]]).flatten.reject(&:blank?)
      @artists = Artist.global_search(@filter)
      @articles = Article.global_search(@filter).includes([:artist]).includes([:taggings]).paginate(page: params[:page], per_page: 15)
    else
      @articles = Article.includes([:artist]).includes([:taggings]).paginate(page: params[:page], per_page: 15)
      @articles = Article.includes([:artist]).paginate(page: params[:page], per_page: 15)
    end
  end

  def services
    @services = Service.includes([:artist]).paginate(page: params[:page], per_page: 15)
  end

  def collaborations
    @collaborations = Collaboration.includes([:artist]).paginate(page: params[:page], per_page: 15)
  end

  def lessons
    @lessons = Lesson.includes([:artist]).paginate(page: params[:page], per_page: 15)
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
    @article_array = []
    @collaboration_array = []
    @service_array = []
    @lesson_array = []
    @artist_array = []

    #91520:  check the bullet gem here, I don't get what it's saying.
    @user.all_following.sort_by { |followed| followed }.each do |following|
      following.arts.map { |art| @art_array << art }
      following.articles.map { |article| @article_array << article }
      following.collaborations.map { |collaboration| @collaboration_array << collaboration }
      following.services.map { |service| @service_array << service }
      following.lessons.map { |lesson| @lesson_array << lesson }
      @artist_array << following
      # raise
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
    @followers = @artist.followers.paginate(page: params[:page], per_page: 15)
  end

  def liked  #HOW THE FUCK DID HE DO THIS?
    @user = current_user
    @artists = @user.find_liked_items.map { |item| item.is_a?(Artist) ? item : nil }.compact.paginate(page: params[:page], per_page: 15)
    @arts = @user.find_liked_items.map { |item| item.is_a?(Art) ? item : nil }.compact.paginate(page: params[:page], per_page: 15)
    @collaborations = @user.find_liked_items.map { |item| item.is_a?(Collaboration) ? item : nil }.compact.paginate(page: params[:page], per_page: 15)
    @services = @user.find_liked_items.map { |item| item.is_a?(Service) ? item : nil }.compact.paginate(page: params[:page], per_page: 15)
    @articles = @user.find_liked_items.map { |item| item.is_a?(Article) ? item : nil }.compact.paginate(page: params[:page], per_page: 15)
    @lessons = @user.find_liked_items.map { |item| item.is_a?(Lesson) ? item : nil }.compact.paginate(page: params[:page], per_page: 15)
  end

  private

  # def pagy_get_items(array, pagy)
  #   array[pagy.offset, pagy.items]
  # end

#   def subscription_params
#     params.require(:subscription).permit(:email)
#   end
# #
end

