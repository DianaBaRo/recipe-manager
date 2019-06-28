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
    5.times { @recipe.recipe_ingredients.build }
    2.times { @recipe.recipe_categories.build }
  end
  
  def create
    recipe = current_user.recipes.create(recipe_params)
    if recipe.save
      recipe.add_ingredients_to_recipe(recipe_ingredient_params)
      recipe.add_categories_to_recipe(recipe_category_params)
      redirect_to recipe_path(recipe), notice: "Your recipe has successfully been added"
    else
      @recipe = Recipe.new
      redirect_to new_recipe_path
    end
  end

  def show
    @recipe = Recipe.find_by_id(params[:id])
  end

  def edit 
    @recipe = Recipe.find_by_id(params[:id])
    if @recipe
      @ingredients = 2.times.collect { @recipe.recipe_ingredients.build }
      @categories = 2.times.collect { @recipe.recipe_categories.build }
    end
  end
  
  def update
    recipe = Recipe.find_by_id(params[:id])
    if recipe.update(recipe_params)
      recipe.add_ingredients_to_recipe(recipe_ingredient_params)
      recipe.add_categories_to_recipe(recipe_category_params)
      redirect_to recipe_path(recipe)
    else
      redirect_to new_recipe_path, alert: recipe.errors.full_messages.each {|m| m}.join
    end
  end

  def destroy
    recipe = Recipe.find_by_id(params[:id])
    recipe.destroy
    redirect_to recipes_path
  end

  private
  def recipe_params
    params.require(:recipe).permit(:name, :cooking_time, :servings, :directions)
  end

  def recipe_ingredient_params
    params.require(:recipe).permit(recipe_ingredients_attributes: [:quantity, :ingredient_id, ingredient: [:name]])
  end

  def recipe_category_params
    params.require(:recipe).permit(recipe_categories_attributes: [:category_id, category: [:name]])
  end
     
end