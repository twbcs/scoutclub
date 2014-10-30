class ArticlesController < ApplicationController
  def index
    @articles = Article.all.includes(:user, :art_type)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(art_params)
    @article.set_user(current_user.id)
    if @article.save
      redirect_to article_path(@article.id)
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(art_params)
      redirect_to article_path(@article.id)
    else
      render :edit
    end
  end

  def show
    @article  = Article.where(id: params[:id]).includes(:user, :art_type).first
    @comments = Comment.where(article_id: params[:id]).includes(:user)
    @comment = Comment.new
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private
  def art_params
    params.require(:article).permit(:title, :content, :user_id, :art_type_id)
  end
end
