class ArtsController < ApplicationController
  def index
    @arts = Art.all
  end


  def new
    @artist = Artist.find(params[:member_id])
    @art = Art.new
  end

  def create
    @art = Art.new(art_params)
    @artist = Artist.find(params[:member_id])
    @art.artist = @artist
    if @art.save
      redirect_to @art.artist
    else
      render "new"
    end
  end

  def show
    @art = Art.find(params[:id])
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

  private

  def art_params
    params.require(:art).permit(:title, :photo, :description, :completion_date, :inspiration, :available, :price_cents)
  end
end
