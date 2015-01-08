class Dashboard::Admin::ArticlesController < Dashboard::Admin::AdminController
  before_action :set_article, only: [:edit, :update, :destroy]
  def index
    if params[:art_kind_id]
      @articles = Article.where(art_kind_id: params[:art_kind_id]).includes(:user, :art_kind)
                  .paginate(page: params[:page], per_page: 10)
    else
      @articles = Article.all.includes(:user, :art_kind).paginate(page: params[:page], per_page: 10)
    end
    @art_kind = ArtKind.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(art_params)
    @article.set_user(current_user.id)
    if @article.save
      redirect_to dashboard_admin_article_path(@article.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(art_params)
      redirect_to dashboard_admin_article_path(@article.id)
    else
      render :edit
    end
  end

  def show
    @article  = Article.where(id: params[:id]).includes(:user, :art_kind).first
    @comments = Comment.where(article_id: params[:id]).includes(:user)
    @comment = Comment.new(article_id: @article.id)
  end

  def append
    if Comment.where(user_id: current_user.id).count > 0
      check = Comment.where(user_id: current_user.id).last.created_at
    end
    @save = false
    if check == nil? || (Time.now - check)  > 5 #避免因JS問題重複回應
      @comment = Comment.new(comment_params)
      @comment.set_user(current_user.id)
      @comment.save
      @save = true
    end
    respond_to(:js)
  end

  def comment_destroy
    @comment = Comment.where(id: params[:comment_id], article_id: params[:article_id]).first
    @comment.destroy
    respond_to(:js)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to dashboard_admin_articles_path
  end

  private

  def art_params
    params.require(:article).permit(:title, :content, :user_id, :art_kind_id)
  end

  def comment_params
    params.require(:comment).permit(:content, :article_id, :user_id)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
