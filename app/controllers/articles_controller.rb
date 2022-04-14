class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]
  before_action :find_article, only: [:show, :edit, :update, :destroy]

  ARTICLES_PER_PAGE = 3
  def index
    @page = params.fetch(:page, 0).to_i
    @articles = Article.offset(@page * ARTICLES_PER_PAGE).limit(ARTICLES_PER_PAGE)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end

    def find_article
      @article = Article.find(params[:id])
    end
end
