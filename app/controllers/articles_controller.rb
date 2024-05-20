class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params.require(:article).permit(:title, :description, :body, :image, pictures: []))
    @article.user_id = current_user.id
    if @article.save
      redirect_to @article, notice: "You have successfully created an article!"
    else
      render :new, alert: "There was an error while creating this article", status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(params.require(:article).permit(:title, :description, :body, :image, pictures: []))
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  def first_article
    @article_first = Article.first
  end

  def correct_user
    @article = current_user.articles.find_by(id: params[:id])
    redirect_to root_path, alert: "Not Authorized" if @article.nil?
  end
end
