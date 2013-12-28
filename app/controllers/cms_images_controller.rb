class CmsImagesController < ApplicationController
  
  before_filter :authenticate_user!, except: [:show, :index, :upload]
  before_filter :find_objects
  before_filter :authorize, except: [:index, :show, :upload]

  def index
    @cms_images = @account.cms_images
  end

  def show
  end

  def new
    @cms_image = Cms::Image.new
  end

  def edit
  end

  def create

    if params[:cms_image]
      @cms_image = Cms::Image.new(params[:cms_image])    
    else
      a = JSON.parse(params["file"].to_json)
      @cms_image = Cms::Image.new
      @cms_image.account_id = @account.id
      @cms_image.title = a["original_filename"]
      @cms_image.image_file = params[:file]
    end
    if @cms_image.save
      respond_to do |format|
        if params[:cms_image]
          format.html{redirect_to user_account_cms_images_path(@account.owner, @account.slug, file_id: @cms_image.slug), notice: t("c.s")}
        else          
          format.json { render json: {filename: @cms_image.image_file_url, error: ""}}
        end   
      end
    else
      respond_to do |format|
        if params[:cms_image]
          format.html{render action: "new", notice: t("c.s")}
        else          
          format.json { render json: {error: @cms_image.errors}}
        end   
      end        
    end
  end

  def update
    if @cms_image.update_attributes(params[:cms_image])
      redirect_to user_account_cms_article_path(@account.owner, @account.slug, file_id: @cms_image.slug), notice: t("u.s")
    else
      render action: "edit"
    end
  end

  def destroy
    @cms_image.destroy
    redirect_to user_account_cms_images_path(@account.owner, @account.slug)
  end
  
  private
  
  def find_objects
    if params[:file_id].present? 
      @cms_image = @account.cms_images.find(params[:file_id])
    end
  end
  
  def authorize
    if !@is_admin
      redirect_to root_url, error: "Permission denied."
    end
  end

end
