class DataFilzsController < ApplicationController
  
  before_filter :authenticate_user!, except: [:show, :index, :raw, :to_csv]
  before_filter :find_objects
  before_filter :authorize, except: [:index, :show, :license, :readme, :raw]
  
  def index
    @data_filzs = @account.data_filzs.where(category: "data")
  end
  
  def apis
    @data_queries = Data::Query.all_(current_user, @account)
    @api_filz = Api::Filz.new
  end
  
  def pull
    @data_query = Data::Query.find(params[:qid])
    @api_account = Api::Account.find(params[:api_filz][:api_account_id])
    if !@data_query.is_oauth_done?(current_user)
      redirect_to apis_user_account_data_filzs_path(@account.owner, @account.slug), error: "Source is not authenticated."
    elsif @data_query.is_used?(@account)
      redirect_to apis_user_account_data_filzs_path(@account.owner, @account.slug), error: "Already pulling"
    else
      Api::Filz.upsert(@account.id, @api_account.id, @data_query.id)
      redirect_to apis_user_account_data_filzs_path(@account.owner, @account.slug), notice: "All well"
    end      
  end
  
  def csv
    send_data Core::Services.twod_to_csv(JSON.parse(@data_filz.content)), :type => "application/vnd.ms-excel", :filename => "#{@data_filz.file_file_name}.csv", :stream => false
  end
  
  def show
    @disable_footer = true
  end
  
  def raw
    render layout: "no_html"
  end
  
  def new
    @data_filz = Data::Filz.new
    @disable_footer = true
    render action: (@editor == "text" ? "text_form" : "csv_form")
  end
  
  def create
    @data_filz = Data::Filz.new(params[:data_filz])
    if @data_filz.save
      flash[:notice] = t("c.s")
      redirect_to user_account_data_filz_path(@account.owner, @account.slug, file_id: @data_filz.slug), :locals => {:flash => flash}
    else
      gon.errors = @data_filz.errors 
      flash[:error] = t("c.f")
      render action: (@editor == "text" ? "text_form" : "csv_form"), :locals => {:flash => flash}
    end
  end
  
  def edit
    @disable_footer = true
    render (@editor == "text" ? "text_form" : "csv_form")
  end
  
  def update
    if @data_filz.update_attributes(params[:data_filz])
      redirect_to user_account_data_filz_path(@account.owner, @account.slug, file_id: @data_filz.slug), notice: t("u.s")
    else
      gon.errors = @data_filz.errors 
      flash[:error] = t("c.f")
      render action: (@editor == "text" ? "text_form" : "csv_form"), :locals => {:flash => flash}
    end
  end
  
  def destroy
    @data_filz.destroy
    redirect_to user_account_data_filzs_path(@account.owner, @account.slug)
  end
  
  def license
    @data_filz = @account.data_filzs.license.first
    @folder = "_"
    @editor = "text"
    @disable_delete = true
    render "show"
  end
  
  def readme
    @data_filz = @account.data_filzs.readme.first
    @folder = "_"
    @editor = "text"
    @disable_delete = true
    render "show"
  end
  
  private
  
  def find_objects
    @editor = "csv"
    if params[:file_id].present? 
      @data_filz = @account.data_filzs.find(params[:file_id])
      if @data_filz.genre == "license" or @data_filz.genre == "readme"
        @editor = "text"
      end
    end
  end
  
  def authorize
    if !@is_admin
      redirect_to root_url, error: "Permission denied."
    end
  end
  
end
