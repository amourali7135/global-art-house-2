class LessonsController < ApplicationController
  # before_action :set_article, only: [:show, :edit, :update, :destroy]
  # before_action :set_artist, only: [:index, :show, :new, :edit, :create, ]
  skip_before_action :authenticate_user!, only: [:index, :show]

  # GET /lessons
  def index
    @artist = Artist.find(params[:artist_id]) #why is this here?
    @lessons = Lesson.paginate(page: params[:page], per_page: 10)
  end

  # GET /lessons/new
  def new
    @artist = Artist.find(params[:artist_id])
    @lesson = Lesson.new
  end

  # POST /lessons
  def create
    @lesson = Lesson.new(lesson_params)
    @artist = Artist.find_by(artist_name: params[:artist_id])
    @lesson.artist = @artist
    if @lesson.save
      flash[:notice] = "Your lesson was successfully created!"
      redirect_to dashboard_path
    else
      flash[:notice] = "There was an error, please try again!"
      render "new"
    end
  end

  # GET /lessons/1
  def show
    @lesson = Lesson.friendly.find(params[:id])
    @artist = @lesson.artist #nested, he changed it to make it work...OHHHH.
    @lesson.punch(request)
  end

  # PATCH/PUT /lessons/1
  def update
    @lesson = Lesson.friendly.find(params[:id])
    if @lesson.update(lesson_params)
      flash[:notice] = "Your lesson was successfully updated!"
      redirect_to dashboard_path
    else
      flash[:error] = "There was an error, please try again!"
      render 'edit'
    end
  end

  # DELETE /lessons/1
  def destroy
    @lesson = Lesson.friendly.find(params[:id])
    @lesson.destroy
    flash[:notice] = "Your lesson was successfully deleted!"
    redirect_to dashboard_path
  end


  # GET /lessons/1/edit
  def edit
    @artist = Artist.find_by(artist_name: params[:artist_id])
    @lesson = Lesson.friendly.find(params[:id])
  end

  def likes
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @lesson = Lesson.find(params[:id])
    @lesson.liked_by @user
    redirect_to @lesson, notice: "Liked this lesson successfully!"
  end

  def unlikes
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @lesson = Lesson.find(params[:id])
    @lesson.unliked_by @user
    redirect_to @lesson, notice: "Unliked this lesson successfully!"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  # def set_article
  #   @lesson = Lesson.find(params[:id])
  # end

  def set_artist
    # @artist = Artist.find(params[:id])
    # @artist = Artist.find_by(artist_name: params[:artist_id])
  end

  # Only allow a trusted parameter "white list" through.
  def lesson_params
    params.require(:lesson).permit(:title, :description, :photo, :subdescription, :photo_cache, :learnings, :rating, :students, :prerequisites, :free, :price_cents, tag_list: [])
  end
end

