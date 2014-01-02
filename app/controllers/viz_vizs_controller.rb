class VizVizsController < ApplicationController

  before_filter :authenticate_user!, except: [:show, :index]
  before_filter :find_objects
  before_filter :authorize, except: [:index, :show]

  def index
    @viz_vizs = @account.viz_vizs
  end

  def map
  end

  def show
    if @viz_viz.map.blank? and current_user.present?
      redirect_to map_user_account_viz_viz_path(@account.owner, @account.slug, file_id: @viz_viz.slug)
    end
  end

  def new   
    @viz_viz = Viz::Viz.new
    @vizs = Viz::Chart.all
    @viz_types = @vizs.collect{ |viz| viz.genre }
    @viz_types.uniq!
  end

  def edit
    if @viz_viz.map.blank?
      redirect_to map_user_account_viz_viz_path(@account.owner, @account.slug, file_id: @viz_viz.slug)
    end
    @mapped_output = JSON.parse(@viz_viz.mapped_output)
  end

  def create

    @viz_viz = Viz::Viz.new(params[:viz_viz])
    if @viz_viz.save
      flash[:notice] = t("c.s")
      redirect_to map_user_account_viz_viz_path(@account.owner, @account.slug, file_id: @viz_viz.slug), :locals => {:flash => flash}
    else
      gon.errors = @viz_viz.errors
      flash[:error] = t("c.f")
      render action: "new", :locals => {:flash => flash}
    end
  end

  def put_map
    @viz_viz.update_attributes(map: params[:data])
    redirect_to edit_user_account_viz_viz_path(@account.owner.slug, @account.slug, @viz_viz.slug)
  end

  def update
    if @viz_viz.update_attributes(params[:viz_viz])
      if @viz_viz.map.blank?
        redirect_to map_user_account_viz_viz_path(@account.owner, @account.slug, file_id: @viz_viz.slug)
      else
        redirect_to user_account_viz_viz_path(@account.owner, @account.slug, file_id: @viz_viz.slug), notice: t("u.s")
      end
    else
      gon.errors = @viz_viz.errors
      if @viz_viz.map.blank?
        render action: "map"
      else
        render action: "edit"
      end
    end
  end

  def destroy
    @viz_viz.destroy
    redirect_to user_account_viz_vizs_path(@account.owner, @account.slug)
  end

  private

  def find_objects
    @viz_charts = Viz::Chart.all
    @data_filzs = @account.data_filzs.where(category: "data")
    if params[:file_id].present?
      @viz_viz = @account.viz_vizs.find(params[:file_id])
    end
  end

  def authorize
    if !@is_admin
      redirect_to root_url, error: "Permission denied."
    end
  end

end
