class CommentsController < ApplicationController
  before_action :require_login
  
  def new
    if @recipe = Recipe.find_by_id(params[:recipe_id])
      @comment = @recipe.comments.build
    else
      @comment = Comment.new
    end
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to comment_path(@comment)
    else
      render :new
    end
  end

  def show
    @comment = Comment.find_by_id(params[:id])
  end

  def index

    @users = User.all
    @recipes = Recipe.all

    if !params[:user].blank?
      @comments = Comment.by_user(params[:user])
    elsif !params[:recipe].blank?
      @comments = Comment.by_recipe(params[:recipe])
    elsif @recipe = Recipe.find_by_id(params[:recipe_id])
      #nested
      @comments = @recipe.comments
    else
      #it's not nested
      @comments = Comment.all
    end
    
  end

  private
  def comment_params
    params.require(:comment).permit(:recipe_id, :content)
  end

end