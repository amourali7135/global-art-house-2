class PhotosController < ApplicationController
  # def create
  #   @photo = Photo.new(photo_params)
  #   @art = Art.find(params[:art_id])
  #   @photo.art = @art

  #   if @photo.save
  #     redirect_to @art
  #   else
  #     render 'arts/show'
  #   end
  # end

  private

  def photo_params
    params.require(:photo).permit(:photo)
  end
end
