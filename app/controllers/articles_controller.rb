class ArticlesController < ApplicationController
  before_action :zero_authors_or_authenticated, except: [:index, :show]

  def zero_authors_or_authenticated
    unless Author.count == 0 || current_user
      redirect_to root_path
      return false
    end
  end

  def index
    @articles = Article.all

    @first_time = true if Author.count == 0

  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comment.article_id = @article.id
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.save

    flash.notice = "Article #{@article.title} created!"

    redirect_to article_path(@article)
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)

    flash.notice = "Article #{@article.title} updated!"

    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    flash.alert = "Article deleted"

    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :tag_list, :image)
    end

end
