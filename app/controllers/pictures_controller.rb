class PicturesController < ApplicationController

  def index
    if params[:q]
      @pictures = Picture.where("title LIKE ? OR artist LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%") 
    else
      @pictures = Picture.all
    end
  end


  def show
    @picture = Picture.find(params[:id])
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = Picture.new(picture_params)
    if @picture.save
      redirect_to pictures_url
    else
      render :new
    end  
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def update
    @picture = Picture.find(params[:id])

    if @picture.update_attributes(picture_params)
      redirect_to picture_path(@picture)
      #also possible: redirect_to @picture
    else
      render :edit
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to pictures_url
  end


  private

  def picture_params
    params.require(:picture).permit(:artist, :title, :url)
  end

end
