class ArticlesController < ApplicationController
  def index
    if params[:art_kind_id]
      @articles = Article.where(art_kind_id: params[:art_kind_id])
                  .includes(:user, :art_kind)
                  .paginate(page: params[:page], per_page: 10)
    else
      @articles = Article.all.includes(:user, :art_kind)
                  .paginate(page: params[:page], per_page: 10)
    end
    @art_kind = ArtKind.all
  end

  def show
    @article  = Article.where(id: params[:id]).includes(:user, :art_kind).first
    @comments = Comment.where(article_id: params[:id]).includes(:user)
    @comment  = Comment.new(article_id: @article.id)
  end
end
