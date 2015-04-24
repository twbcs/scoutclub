class ArticlesController < ApplicationController
  def index
    if params[:art_kind_id]
      @articles = Article.where(art_kind_id: params[:art_kind_id])
                  .includes(:user, :art_kind).page_set(params[:page])
    else
      @articles = Article.all.includes(:user, :art_kind).page_set(params[:page])
    end
    @art_kind = ArtKind.all
  end

  def show
    @article  = Article.where(id: params[:id]).includes(:user, :art_kind).first
    @comments = Comment.where(article_id: params[:id]).includes(:user)
    @comment  = Comment.new(article_id: @article.id)
  end
end
