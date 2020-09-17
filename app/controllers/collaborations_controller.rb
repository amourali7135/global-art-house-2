class CollaborationsController < ApplicationController
  # before_action :set_article, only: [:show, :edit, :update, :destroy]
  # before_action :set_artist, only: [:index, :show, :new, :edit, :create, ]
  skip_before_action :authenticate_user!, only: [:index, :show]

  # GET /collaborations
  def index
    @artist = Artist.find(params[:artist_id]) #why is this here?
    @collaborations = Collaboration.paginate(page: params[:page], per_page: 10)
  end

  # GET /collaborations/new
  def new
    @artist = Artist.find(params[:artist_id])
    @collaboration = Collaboration.new
  end

  # POST /collaborations
  def create
    @collaboration = Collaboration.new(collaboration_params)
    # @artist = Artist.find(params[:artist_id])
    @artist = Artist.find_by(artist_name: params[:artist_id])
    # @artist = current_user.artist_id
    @collaboration.artist = @artist
    if @collaboration.save
      flash[:notice] = "Your collaboration was successfully created!"
      redirect_to dashboard_path
    else
      flash[:notice] = "There was an error, please try again!"
      render "new"
    end
  end

  # GET /collaborations/1
  def show
    # @comment = Comment.new
    @collaboration = Collaboration.friendly.find(params[:id])
    # @collaboration = Collaboration.find(params[:id])
    @artist = @collaboration.artist #nested, he changed it to make it work...OHHHH.
    @collaboration.punch(request)
  end

  # PATCH/PUT /collaborations/1
  def update
    # @collaboration = Collaboration.find(params[:id])
    @collaboration = Collaboration.friendly.find(params[:id])
    if @collaboration.update(collaboration_params)
      flash[:notice] = "Your collaboration was successfully updated!"
      redirect_to dashboard_path
    else
      flash[:error] = "There was an error, please try again!"
      render 'edit'
    end
  end

  # DELETE /collaborations/1
  def destroy
    @collaboration = Collaboration.friendly.find(params[:id])
    # @collaboration = Collaboration.find(params[:id])
    @collaboration.destroy
    flash[:notice] = "Your collaboration was successfully deleted!"
    redirect_to dashboard_path
  end


  # GET /collaborations/1/edit
  def edit
    @artist = Artist.find_by(artist_name: params[:artist_id])
    @collaboration = Collaboration.friendly.find(params[:id])
    # @collaboration = Collaboration.find(params[:id])
  end

  def likes
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @collaboration = Collaboration.friendly.find(params[:id])
    @collaboration.liked_by @user
    redirect_to @collaboration, notice: "Liked this collaboration successfully!"
  end

  def unlikes
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @collaboration = Collaboration.friendly.find(params[:id])
    @collaboration.unliked_by @user
    redirect_to @collaboration, notice: "Unliked this collaboration successfully!"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  # def set_article
  #   @collaboration = Collaboration.find(params[:id])
  # end

  def set_artist
    # @artist = Artist.find(params[:id])
    # @artist = Artist.find_by(artist_name: params[:artist_id])
  end

  # Only allow a trusted parameter "white list" through.
  def collaboration_params
    params.require(:collaboration).permit(:title, :description, :photo, :goal, :slug, :photo_cache, tag_list: [])
  end
end

