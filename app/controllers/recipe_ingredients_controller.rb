class RecipeIngredientsController < ApplicationController
  before_action :require_login
  before_action :admin_only
    
  def new
    if recipe
      @recipe_ingredient = @recipe.recipe_ingredients.new
    else
      @recipe_ingredient = RecipeIngredient.new
    end

    @ingredient = Ingredient.new
    @ingredients = Ingredient.all
  end
  
  def create
    if selecting_and_creating_ingredient #user is selecting and creating an ingredient
      flash[:error] = "Please, select an ingredient or create a new one, not both."
      @recipe_ingredient = RecipeIngredient.new
      @ingredient = Ingredient.new
      render :new and return
    end

    @recipe_ingredient = RecipeIngredient.create(recipe_ingredient_params)
      
    if creating_ingredient #user is creating the ingredient
      Ingredient.create(recipe_ingredient_params[:ingredient_attributes])
    else #user is selecting the ingredient
      @recipe_ingredient.ingredient = Ingredient.find_by_id(recipe_ingredient_params[:ingredient_id])
    end

    if @recipe_ingredient.save
      redirect_to recipe_path(@recipe_ingredient.recipe_id)
    else
      render :new
    end
  end

  def index
    recipe
  end

  def destroy_multiple
    RecipeIngredient.destroy(params[:recipe_ingredients])
    redirect_to recipes_path
  end 

  private
  def recipe_ingredient_params
    params.require(:recipe_ingredient).permit(:recipe_id, :ingredient_id, :quantity, ingredient_attributes: [:name])
  end

  def recipe
    @recipe = Recipe.find_by_id(params[:recipe_id])
  end

  def selecting_and_creating_ingredient
    recipe_ingredient_params[:ingredient_id] != "" && recipe_ingredient_params[:ingredient_attributes][:name] != ""
  end

  def creating_ingredient
    recipe_ingredient_params[:ingredient_id] == ""
  end
  
end