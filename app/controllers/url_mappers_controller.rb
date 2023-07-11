class UrlMappersController < ApplicationController
  def index
    @url_mappers = UrlMapper.all
  end

  def new
    @url_mapper = UrlMapper.new
  end

  def create
    @url_mapper = UrlMapper.new(url_mapper_params)
    if @url_mapper.save
      redirect_to dashboard_path
    else
      binding.pry
      flash[:errors] = @url_mapper.errors.full_messages
      render 'new'
    end
  end

  def edit
    @url_mapper = UrlMapper.find(params[:id])
  end


  def update
    @url_mapper = UrlMapper.find(params[:id])
    if @url_mapper.update(url_mapper)
      redirect_to dashboard_path, flash: { success: ["url has been updated successfully."] }
    else
      render 'edit', flash: { errors: @url_mapper.errors.full_messages }
    end
  end

  def destroy
    @url_mapper = UrlMapper.find(params[:id])
    if @url_mapper.destroy
      redirect_to dashboard_path, flash: { success: ["url has been successfully deleted."] }
    else
      redirect_to dashboard_path, flash: { errors: @url_mapper.errors.full_messages }
    end
  end

  def url_mapper_params
    params.require(:url_mapper).permit(:title, :url, :user_id)
  end
end
