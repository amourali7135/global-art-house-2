class ArtsController < ApplicationController
  def index
    @artist = Artist.find(params[:artist_id])
    @arts = Art.all
  end


  def new
    @type = ["Abstract", "Realist", "Neo-hipster", "FML", "Moana"]
    @artist = Artist.find(params[:artist_id])
    @art = Art.new
  end

  def create
    @art = Art.new(art_params)
    @artist = Artist.find(params[:artist_id])
    @art.artist = @artist
    if @art.save
      redirect_to @art.artist
    else
      render "new"
    end
  end

  def show
    @comment = Comment.new
    @art = Art.find(params[:id])
    @artist = @art.artist #nested, he changed it to make it work...OHHHH.
  end

  def update
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
    redirect_to arts
  end

  def edit
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

  def art_params
    params.require(:art).permit(:title, :description, :completion_date, :inspiration, :available, :price_cents, :tags_as_string, :tag_list)
  end

  def create_pictures
    images = params.dig(:art, :photos) || []
    images.each do |image|
      @art.photos.create(image: image)
    end
  end

  end
