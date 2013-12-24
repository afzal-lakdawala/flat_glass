class CmsArticlesController < ApplicationController
  
  before_filter :authenticate_user!, except: [:show, :index]
  before_filter :find_objects
  before_filter :authorize, except: [:index, :show]

  def index
    @cms_articles = @account.cms_articles
  end

  def show
  end

  def new
    @cms_article = Cms::Article.new
  end

  def edit
  end

  def create
    @cms_article = Cms::Article.new(params[:cms_article])
    @cms_article.is_published = false
    if params[:commit] == "Publish"
      @cms_article.is_published = true
    end
    @cms_article.description.to_s.html_safe
    if @cms_article.save
      redirect_to user_account_cms_articles_path(@account.owner, @account.slug, file_id: @cms_article.slug), notice: t("c.s")
    else
      render action: "new"
    end
  end

  def update
    @cms_article.is_published = false
    if params[:commit] == "Publish"
      @cms_article.is_published = true
    end
    @cms_article.description.to_s.html_safe
    if @cms_article.update_attributes(params[:cms_article])
      redirect_to user_account_cms_article_path(@account.owner, @account.slug, file_id: @cms_article.slug), notice: t("u.s")
    else
      render action: "edit"
    end
  end

  def destroy
    @cms_article.destroy
    redirect_to user_account_cms_articles_path(@account.owner, @account.slug)
  end
  
  private
  
  def find_objects
    if params[:file_id].present? 
      @cms_article = @account.cms_articles.find(params[:file_id])
    end
  end
  
  def authorize
    if !@is_admin
      redirect_to root_url, error: "Permission denied."
    end
  end
  
end
