class Api::ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :destroy, :create_comments]
  before_action :authenticate_user!
  # GET /articles
  def index
    @articles = Article.all

    # render json: @articles
  end

  # GET /articles/1
  def show;end

  # POST /articles
  def create
    @article = Article.new(article_params)

    if @article.save
      render json: @article, status: :created
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
  end

  def create_comment
    if save_comment(params[:comment]) 
      render json: @comment
    else
      render json: 'Please enter comment', status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def save_comment(comment)
      @comment = @article.comments.create(comment: comment) unless comment.nil?
    end

    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def article_params
      params.require(:article).permit(:title,:author)
    end
end
