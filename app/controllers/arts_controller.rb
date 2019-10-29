class ArtsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @artist = Artist.find(params[:artist_id])
    # @arts = art.artist
    @arts = params[:tag] ? Art.tagged_with(params[:tag]) : Art.all
  end


  def new
    @kind = ['Painting', 'Drawing', 'Sculpting', 'Architecture', 'Ceramic', 'Electronic', 'Light', 'Graphic', 'Photography', 'Textile', 'Performance', 'Poetry', 'Literature', 'Collage', 'Digital', 'Animation', 'Body', 'Street', 'Graffiti', 'Glass', 'Tapestry', 'Installation', 'Calligraphy', 'Dance', '' ].sort
    @type = ["Abstract", "Realist", "Modern", "Pop", "Cubism", "Deco", "Nouveau", "Surrealism", "Contemporary", "Abstract Expressionism", 'Post-Impressionism', 'Collage', 'Figure Drawing', 'Landscapes', 'Still Life',  'Graffiti', ].sort
    @artist = Artist.find(params[:artist_id])
    @art = Art.new
  end

  def create
    @art = Art.new(art_params)
    @artist = Artist.find(params[:artist_id])
    @art.artist = @artist
    create_pictures(@art)
    if @art.save
      create_tags(@art)
      redirect_to @art.artist
    else
      render "new"
    end
  end

  def show
    @comment = Comment.new
    @art = Art.find(params[:id])
    @artist = @art.artist #nested, he changed it to make it work...OHHHH.
    # @photo = Photo.find(params[:id])
    @art.punch(request)
  end

  def update
    @photo = Photo.find(params[:id])
    @art = Art.find(params[:id])
    if @art.update(art_params)
      redirect_to @art
    else
      render 'edit'
    end
  end

  def destroy
    @art = Art.find(params[:id])
    @art.destroy
    redirect_to arts_path
  end

  def edit
  @kind = ['Painting', 'Drawing', 'Sculpting', 'Architecture', 'Ceramic', 'Electronic', 'Light', 'Graphic', 'Photography', 'Textile', 'Performance', 'Poetry', 'Literature', 'Collage', 'Digital', 'Animation', 'Body', 'Street', 'Graffiti', 'Glass', 'Tapestry', 'Installation', 'Calligraphy', 'Dance', '' ].sort
    @type = ["Abstract", "Realist", "Modern", "Pop", "Cubism", "Deco", "Nouveau", "Surrealism", "Contemporary", "Abstract Expressionism", 'Post-Impressionism', 'Collage', 'Figure Drawing', 'Landscapes', 'Still Life',  'Graffiti', ].sort
    @photo = Photo.find(params[:id])
    @artist = Artist.find(params[:artist_id])
    @art = Art.find(params[:id])
  end

  def likes
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @art = Art.find(params[:id])
    @art.liked_by @user
    redirect_to @art, notice: "Liked this art successfully!"
  end

  def unlikes
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @art = Art.find(params[:id])
    @art.unliked_by @user
    redirect_to @art, notice: "Unliked this art successfully!"
  end

  private

  def create_pictures(art)
    images = params.dig(:art, :photos) || []
    images.each do |image|
      # @art.photos.create(image: image)
      Photo.create!(photo: image, art: art)
    end
  end

  def create_tags(art)
    tags = params.dig(:art, :tag_ids) || []
    tags.reject { |tag| tag == '' }.each do |tag|
      tag_p = Tag.find_by(name: tag) || Tag.create(name: tag)
      ArtTag.create!(art: art, tag: tag_p)
    end
  end

  def art_params
    params.require(:art).permit(:title, :description, :completion_date, :inspiration, :available, :price_cents, :tag_list, :photo, :photos, styles: [], tag_list: [])
  end
end
