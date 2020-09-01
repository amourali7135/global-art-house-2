class ServicesController < ApplicationController
  # before_action :set_article, only: [:show, :edit, :update, :destroy]
  # before_action :set_artist, only: [:index, :show, :new, :edit, :create, ]

  # GET /services
  def index
    @artist = Artist.find(params[:artist_id]) #why is this here?
    @services = Service.paginate(page: params[:page], per_page: 8)
  end

  # GET /services/new
  def new
    @artist = Artist.find(params[:artist_id])
    @service = Service.new
  end

  # POST /services
  def create
    @service = Service.new(service_params)
    # @artist = Artist.find(params[:artist_id])
    @artist = Artist.find_by(artist_name: params[:artist_id])
    # @artist = current_user.artist_id
    @service.artist = @artist
    if @service.save
      flash[:notice] = "Your service was successfully created!"
      redirect_to dashboard_path
    else
      flash[:notice] = "There was an error, please try again!"
      render "new"
    end
  end

  # GET /services/1
  def show
    # @comment = Comment.new
    @service = Service.friendly.find(params[:id])
    # @service = Service.find(params[:id])
    @artist = @service.artist #nested, he changed it to make it work...OHHHH.

    @service.punch(request)
  end

  # PATCH/PUT /services/1
  def update
    # @service = Service.find(params[:id])
    @service = Service.friendly.find(params[:id])
    if @service.update(service_params)
      flash[:notice] = "Your service was successfully updated!"
      redirect_to dashboard_path
    else
      flash[:error] = "There was an error, please try again!"
      render 'edit'
    end
  end

  # DELETE /services/1
  def destroy
    # @service = Service.find(params[:id])
    @service = Service.friendly.find(params[:id])
    @service.destroy
    flash[:notice] = "Your service was successfully deleted!"
    redirect_to dashboard_path
  end


  # GET /services/1/edit
  def edit
    @artist = Artist.find_by(artist_name: params[:artist_id])
    # @service = Service.find(params[:id])
    @service = Service.friendly.find(params[:id])
  end

  def likes
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @service = Service.find(params[:id])
    @service.liked_by @user
    redirect_to @service.artist, notice: "Liked this service successfully!"
  end

  def unlikes
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @service = Service.find(params[:id])
    @service.unliked_by @user
    redirect_to @service, notice: "Unliked this service successfully!"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  # def set_article
  #   @service = Service.find(params[:id])
  # end

  def set_artist
    # @artist = Artist.find(params[:id])
    # @artist = Artist.find_by(artist_name: params[:artist_id])
  end

  # Only allow a trusted parameter "white list" through.
  def service_params
    params.require(:service).permit(:title, :description, :length, :photo, :price_cents, tag_list: [] )
  end
end
