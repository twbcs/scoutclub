class ArticlesController < ApplicationController
  before_action :art_count, only: [:index]

  def index
    if params[:art_kind_id]
      @articles = Article.where(art_kind_id: params[:art_kind_id])
                  .includes(:user, :art_kind).page_set(params[:page])
    else
      @articles = Article.all.includes(:user, :art_kind).page_set(params[:page])
    end
  end

  def show
    @article  = Article.where(id: params[:id]).includes(:user, :art_kind).first
    @comments = Comment.where(article_id: params[:id]).includes(:user)
    @comment  = Comment.new(article_id: @article.id)
  end

  private

  def art_count
    @art_kind = ArtKind.all
    @art_count = Article.all.group(:art_kind_id).count
  end
end
