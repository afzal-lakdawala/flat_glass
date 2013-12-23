class DataFilesController < ApplicationController
  
  before_filter :authenticate_user!, except: [:show, :index, :raw]
  before_filter :find_objects
  before_filter :authorize, except: [:index, :show, :license, :readme, :raw]
  
  def index
    @data_files = @account.data_files.where(category: @folder)
  end
  
  def apis
    @data_queries = Data::Query.all_(current_user, @account)
    @api_file = Api::File.new
  end
  
  def pull
    @data_query = Data::Query.find(params[:qid])
    
    if !@data_query.is_oauth_done?(current_user)
      redirect_to apis_user_account_data_files_path(@account.owner, @account.slug, folder_id: @folder), error: "Source is not authenticated."
    elsif @data_query.is_used?(@account)
      redirect_to apis_user_account_data_files_path(@account.owner, @account.slug, folder_id: @folder), error: "Already pulling"
    else
      redirect_to apis_user_account_data_files_path(@account.owner, @account.slug, folder_id: @folder), notice: "All well"
    end      
  end
  
  def show
  end
  
  def raw
    render layout: "no_html"
  end
  
  def new
    @data_file = Data::File.new
    @data_file.commit_message = "First commit"
  end
  
  def create
    @data_file = Data::File.new(params[:data_file])
    if @data_file.save
      flash[:notice] = t("c.s")
      redirect_to user_account_data_file_path(@account.owner, @account.slug, folder_id: @folder, file_id: @data_file.slug), :locals => {:flash => flash}
    else
      gon.errors = @data_file.errors 
      flash[:error] = t("c.f")
      render action: "new", :locals => {:flash => flash}
    end
  end
  
  def edit
  end
  
  def update
    if @data_file.update_attributes(params[:data_file])
      redirect_to user_account_data_file_path(@account.owner, @account.slug, folder_id: @folder, file_id: @data_file.slug), notice: t("u.s")
    else
      gon.errors = @data_file.errors
      render action: "edit" 
    end
  end
  
  def destroy
    @data_file.destroy
    redirect_to user_account_data_files_path(@account.owner, @account.slug, folder_id: @folder)
  end
  
  def license
    @data_file = @account.data_files.license.first
    @folder = "_"
    @editor = "text"
    @disable_delete = true
    render "show"
  end
  
  def readme
    @data_file = @account.data_files.readme.first
    @folder = "_"
    @editor = "text"
    @disable_delete = true
    render "show"
  end
  
  private
  
  def find_objects
    if params[:folder_id].present?
      @folder = params[:folder_id]
      if params[:file_id].present? 
        @data_file = @account.data_files.find(params[:file_id])
        if @data_file.genre == "license" or @data_file.genre == "readme"
          @editor = "text"
        else
          @editor = "csv"
        end
      end
    end
  end
  
  def authorize
    if !@is_admin
      redirect_to root_url, error: "Permission denied."
    end
  end
  
end
