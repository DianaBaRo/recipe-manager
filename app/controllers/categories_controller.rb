class CategoriesController < ApplicationController
  before_action :require_login
  before_action :admin_only, except: [:index, :show]

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    if @category.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end
  
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by_id(params[:id])
    @recipes = @category.recipes
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

end