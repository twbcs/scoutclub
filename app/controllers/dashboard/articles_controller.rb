class Dashboard::ArticlesController < Dashboard::DashboardController
  before_action :is_inside, only: [:new, :create, :edit, :update]
  before_action :set_article, only: [:edit, :update]
  before_action :art_count, only: [:index]

  def index
    if params[:art_kind_id]
      @articles = Article.where(art_kind_id: params[:art_kind_id])
                  .includes(:user, :art_kind).page_set(params[:page])
    else
      @articles = Article.all.includes(:user, :art_kind).page_set(params[:page])
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(art_params)
    @article.setup_user(current_user.id)
    if @article.save
      redirect_to dashboard_article_path(@article.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(art_params)
      redirect_to dashboard_article_path(@article.id)
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
    if Comment.where(user_id: current_user.id).any?
      check = Comment.where(user_id: current_user.id).last.created_at
    end
    @save = false
    if check == nil? || (Time.now - check) > 5  # anti-JS rep
      @comment = Comment.new(comment_params)
      @comment.setup_user(current_user.id)
      @comment.save
      @save = true
    end
    respond_to(:js)
  end

  def comment_destroy
    @comment = Comment.where(id: params[:comment_id],
                             article_id: params[:article_id]).first
    @comment.destroy
    respond_to(:js)
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

  def art_count
    @art_kind = ArtKind.all
    @art_count = Article.all.group(:art_kind_id).count
  end
end
