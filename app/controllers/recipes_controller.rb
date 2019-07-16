class RecipesController < ApplicationController
  before_action :require_login
  before_action :admin_only, except: [:index, :show, :newest_recipe]
  
  def index
    @users = User.all
    @categories = Category.all

    if !params[:name].blank? #filtering recipes by name
      @recipes = Recipe.by_name(params[:name])
    elsif !params[:user].blank? #filtering recipes by user
      @recipes = Recipe.by_user(params[:user])
    else
      @recipes = Recipe.all
    end
  end
    
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = current_user.recipes.create(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def show
    recipe
  end

  def edit 
    recipe
  end
  
  def update
    recipe
    if recipe.update(recipe_params)
      redirect_to recipe_path(recipe)
    else
      render :edit
    end
  end

  def destroy
    recipe.destroy
    redirect_to recipes_path
  end

  def newest_recipe
    @recipe = Recipe.latest
  end

  private
  def recipe_params
    params.require(:recipe).permit(:name, :cooking_time, :servings, :directions, category_ids: [])
  end

  def recipe
    @recipe = Recipe.find_by_id(params[:id])
  end
     
end