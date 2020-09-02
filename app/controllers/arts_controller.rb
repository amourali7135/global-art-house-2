class ArtsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  #WTF is going on up in here?  Take better notes from now on!  61420
  def index
    @artist = Artist.find(params[:artist_id]) #why is this here?
    @arts = Art.paginate(page: params[:page], per_page: 15)
  end


  def new
    @kind = ['Painting', 'Drawing', 'Sculpting', 'Architecture', 'Ceramic', 'Electronic', 'Light', 'Graphic', 'Photography', 'Textile', 'Performance', 'Poetry', 'Literature', 'Collage', 'Digital', 'Animation', 'Body', 'Street', 'Graffiti', 'Glass', 'Tapestry', 'Installation', 'Calligraphy', 'Dance', '' ].sort
    @type = ["Abstract", "Realist", "Modern", "Pop", "Cubism", "Deco", "Nouveau", "Surrealism", "Contemporary", "Abstract Expressionism", 'Post-Impressionism', 'Collage', 'Figure Drawing', 'Landscapes', 'Still Life',  'Graffiti', ].sort
    @artist = Artist.find(params[:artist_id])
    @art = Art.new
  end

  def create
    @art = Art.new(art_params)
    # @artist = Artist.find(params[:artist_id])
    @artist = Artist.find_by(artist_name: params[:artist_id])
    @art.artist = @artist
    if @art.save
      flash[:notice] = "Your art was successfully created!"
      redirect_to dashboard_path
    else
      render "new"
    end
  end

  def show
    # @comment = Comment.new
    @art = Art.friendly.find(params[:id])
    @artist = @art.artist #nested, he changed it to make it work...OHHHH.
    @art.punch(request)
    # commontator_thread_show(@art)
  end

  def update
    # @art = Art.find(params[:id])
    @art = Art.friendly.find(params[:id])
    if @art.update(art_params)
      flash[:notice] = "Your art was successfully updated!"
      redirect_to dashboard_path
    else
      flash[:error] = "There was an error, please try again!"
      render 'edit'
    end
  end

  def destroy
    # @art = Art.find(params[:id])
    @art = Art.friendly.find(params[:id])
    @art.destroy
    flash[:notice] = "Your art was successfully deleted!"
    redirect_to dashboard_path
  end

  def edit
    @kind = ['Painting', 'Drawing', 'Sculpting', 'Architecture', 'Ceramic', 'Electronic', 'Light', 'Graphic', 'Photography', 'Textile', 'Performance', 'Poetry', 'Literature', 'Collage', 'Digital', 'Animation', 'Body', 'Street', 'Graffiti', 'Glass', 'Tapestry', 'Installation', 'Calligraphy', 'Dance', '' ].sort
    @type = ["Abstract", "Realist", "Modern", "Pop", "Cubism", "Deco", "Nouveau", "Surrealism", "Contemporary", "Abstract Expressionism", 'Post-Impressionism', 'Collage', 'Figure Drawing', 'Landscapes', 'Still Life',  'Graffiti', ].sort
    @artist = Artist.find_by(artist_name: params[:artist_id])
    # @art = Art.find(params[:id])
    @art = Art.friendly.find(params[:id])
  end

  def likes
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @art = Art.find(params[:id])
    @art.liked_by @user
    redirect_to @art.artist, notice: "Liked this art successfully!"
  end

  def unlikes
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @art = Art.find(params[:id])
    @art.unliked_by @user
    redirect_to @art, notice: "Unliked this art successfully!"
  end

  private

  def art_params
    params.require(:art).permit(:title, :description, :completion_date, :inspiration, :available, :price_cents, :tag_list, :photo, :photos, styles: [], tag_list: [])
  end
end
