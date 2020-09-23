class ArticlesController < ApplicationController
  # before_action :set_article, only: [:show, :edit, :update, :destroy]
  # before_action :set_artist, only: [:index, :show, :new, :edit, :create, ]
  skip_before_action :authenticate_user!, only: [:index, :show]

  # GET /articles
  def index
    @artist = Artist.friendly.find(params[:artist_id]) #why is this here?
    @articles = Article.paginate(page: params[:page], per_page: 8)
  end

  # GET /articles/new
  def new
    @artist = Artist.friendly.find(params[:artist_id])
    @article = Article.new
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    @artist = Artist.friendly.find(params[:artist_id])
    # @artist = Artist.find_by(artist_name: params[:artist_id])
    # @artist = current_user.artist_id
    @article.artist = @artist
    if @article.save
      flash[:notice] = "Your article was successfully created!"
      redirect_to dashboard_path
    else
      flash[:notice] = "There was an error, please try again!"
      render "new"
    end
  end

  # GET /articles/1
  def show
    # @comment = Comment.new
    @article = Article.friendly.find(params[:id])
    # @article = Article.find(params[:id])
    @artist = @article.artist #nested, he changed it to make it work...OHHHH.
    @article.punch(request)
  end

  # PATCH/PUT /articles/1
  def update
    # @article = Article.find(params[:id])
    @article = Article.friendly.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Your article was successfully updated!"
      redirect_to dashboard_path
    else
      flash[:error] = "There was an error, please try again!"
      render 'edit'
    end
  end

  # DELETE /articles/1
  def destroy
    @article = Article.friendly.find(params[:id])
    # @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Your article was successfully deleted!"
    redirect_to dashboard_path
  end


  # GET /articles/1/edit
  def edit
    @artist = Artist.friendly.find(params[:artist_id])
    @article = Article.friendly.find(params[:id])
    # @article = Article.find(params[:id])
  end

  def likes
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @article = Article.friendly.find(params[:id])
    @article.liked_by @user
    redirect_to @article.artist, notice: "Liked this article successfully!"  #Fix this redirect later, it's a strange error.
  end

  def unlikes
    @user = current_user # before_action :authenticate_user, only: [:likes]
    @article = Article.friendly.find(params[:id])
    @article.unliked_by @user
    redirect_to @article, notice: "Unliked this article successfully!"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  # def set_article
  #   @article = Article.find(params[:id])
  # end

  def set_artist
    # @artist = Artist.find(params[:id])
    # @artist = Artist.find_by(artist_name: params[:artist_id])
  end

  # Only allow a trusted parameter "white list" through.
  def article_params
    params.require(:article).permit(:title, :content, :photo, :body, :slug, :photo_cache, tag_list: [])
  end
end
