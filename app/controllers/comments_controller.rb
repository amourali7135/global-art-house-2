class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @comments = @art.comments.includes(:user)
  end
    
    def new
      @comment = Comment.new
    end
    
    
    def create
      @art = Art.find(params[:art_id])
      @comment = @art.comments.create(comment_params)
      @comment.user_id = current_user.id
      if @comment.save
        redirect_to @art
      else
        flash.now[:danger] = "error"
      end
    end
    
    def destroy
      @comment = Comment.find(params[:id])
      @art = @comment.art
      @comment.destroy
      redirect_to @art
    end
    
    private 
    
    def comment_params
      params.require(:comment).permit(:content, :art_id, :user_id)
    end
    
  end
  