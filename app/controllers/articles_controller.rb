class ArticlesController < ApplicationController
  def index
    if params[:art_type_id]
      @articles = Article.where(art_type_id: params[:art_type_id])
    else
      @articles = Article.all.includes(:user, :art_type)
    end
      @art_type = ArtType.all
  end

  def show
    @article  = Article.where(id: params[:id]).includes(:user, :art_type).first
    @comments = Comment.where(article_id: params[:id]).includes(:user)
    @comment = Comment.new(article_id: @article.id)
  end
end
