class RecipesController < ApplicationController
  before_action :require_login
  before_action :admin_only, except: [:index, :show]
  
  def index
    @users = User.all
    @categories = Category.all

    if !params[:name].blank?
      @recipes = Recipe.by_name(params[:name])
    elsif !params[:user].blank?
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
    @recipe = Recipe.find_by_id(params[:id])
  end

  def edit 
    @recipe = Recipe.find_by_id(params[:id])
  end
  
  def update
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def destroy
    recipe = Recipe.find_by_id(params[:id])
    recipe.destroy
    redirect_to recipes_path
  end

  private
  def recipe_params
    params.require(:recipe).permit(:name, :cooking_time, :servings, :directions, :recipe_ingredients_attributes => [:ingredient_id, :quantity, :ingredients_attributes => [:name]])
  end
     
end