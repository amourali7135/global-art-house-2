class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @comments = @art.comments.includes(:user)
  end

  def new
    @comment = Comment.new
  end


  def create
    # @art = Art.find(params[:art_id])
    @art = Art.friendly.find(params[:art_id])
      # @art = Art.find(params[:comment][:id])
    @comment = @art.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "Your comment was successfully posted!"
      redirect_to artist_art_path(@art.artist, @art)
    else
      flash.now[:danger] = "error"
    end
  end

  def destroy
    # @art = Art.find(params[:art_id])
    @art = Art.friendly.find(params[:art_id])
      # @art = Art.find(params[:comment][:id])
    @comment = Comment.find(params[:id])
    @art = @comment.art
    @comment.destroy
    flash[:notice] = "Your comment was successfully deleted!"
    redirect_to artist_art_path(@art.artist, @art)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :art_id, :user_id)
  end

end
