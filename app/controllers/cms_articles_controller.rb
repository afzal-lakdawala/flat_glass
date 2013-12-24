class CmsArticlesController < ApplicationController
  # GET /cms_articles
  # GET /cms_articles.json
  def index
    @cms_articles = CmsArticle.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cms_articles }
    end
  end

  # GET /cms_articles/1
  # GET /cms_articles/1.json
  def show
    @cms_article = CmsArticle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cms_article }
    end
  end

  # GET /cms_articles/new
  # GET /cms_articles/new.json
  def new
    @cms_article = CmsArticle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cms_article }
    end
  end

  # GET /cms_articles/1/edit
  def edit
    @cms_article = CmsArticle.find(params[:id])
  end

  # POST /cms_articles
  # POST /cms_articles.json
  def create
    @cms_article = CmsArticle.new(params[:cms_article])

    respond_to do |format|
      if @cms_article.save
        format.html { redirect_to @cms_article, notice: 'Cms article was successfully created.' }
        format.json { render json: @cms_article, status: :created, location: @cms_article }
      else
        format.html { render action: "new" }
        format.json { render json: @cms_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cms_articles/1
  # PUT /cms_articles/1.json
  def update
    @cms_article = CmsArticle.find(params[:id])

    respond_to do |format|
      if @cms_article.update_attributes(params[:cms_article])
        format.html { redirect_to @cms_article, notice: 'Cms article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cms_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cms_articles/1
  # DELETE /cms_articles/1.json
  def destroy
    @cms_article = CmsArticle.find(params[:id])
    @cms_article.destroy

    respond_to do |format|
      format.html { redirect_to cms_articles_url }
      format.json { head :no_content }
    end
  end
end
