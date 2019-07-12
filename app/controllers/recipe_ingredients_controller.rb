class RecipeIngredientsController < ApplicationController
    before_action :require_login
    
    def new
      if @recipe = Recipe.find_by_id(params[:recipe_id])
        @recipe_ingredient = @recipe.recipe_ingredients.new
      else
        @recipe_ingredient = RecipeIngredient.new
      end
      @ingredient = Ingredient.new
      @ingredients = Ingredient.all
    end
  
    def create

      @recipe_ingredient = RecipeIngredient.create(recipe_ingredient_params)
      
      if recipe_ingredient_params[:ingredient_id] == ""
        Ingredient.create(recipe_ingredient_params[:ingredient_attributes])
      else
        @recipe_ingredient.ingredient = Ingredient.find_by_id(recipe_ingredient_params[:ingredient_id])
      end
      if @recipe_ingredient.save
        redirect_to recipes_path
      else
        render :new
      end
    end

    private
    def recipe_ingredient_params
      params.require(:recipe_ingredient).permit(:recipe_id, :ingredient_id, :quantity, ingredient_attributes: [:name] )
    end
  
  end