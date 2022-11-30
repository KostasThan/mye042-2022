class PhotosController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    if params[:photo] == nil

      flash[:alert] = "Please upload a photo"
      redirect_to :back
    else

      #create the photo and assign it to the current user
      @photo = @user.photos.create(photo_params)
      # @photo.user_id = @user.id
      
      #if we manage to save the photo
      if @photo.save
        flash[:notice] = "Successfully uploaded a photo"
        redirect_to user_path(@user)
      else
        # if the photo can't be saved due to restrictions
        flash[:alert] = "Photo was not uploaded"
        redirect_to new_user_photo_path(@user)
      end

    end
  end

  def new
    @user = User.find(params[:user_id])
    @photo = Photo.create()
  end

  def destroy
    #find the current user
    @user = User.find(params[:user_id])
    
    #find the photo to delete
    @photo = Photo.find(params[:id])


    if @photo.user_id == @user.id
      #delete all the tags
      @photo.tags.each { |t| t.destroy}

      #delete the photo
      @photo.destroy
    end

    #redirect back to user
    redirect_to user_path(@user)
  end
  
  private
  def photo_params
    params.require(:photo).permit(:image, :title)
  end
end
