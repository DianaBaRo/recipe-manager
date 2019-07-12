class RecipeIngredientsController < ApplicationController
    before_action :require_login
    
    def new
      if @recipe = Recipe.find_by_id(params[:recipe_id])
        @recipe_ingredient = RecipeIngredient.new
        @recipe_ingredient.recipe_id = @recipe.id
      else
        @recipe_ingredient = RecipeIngredient.new
      end

      @ingredients = Ingredient.all
    end
  
    def create
      @recipe_ingredient = RecipeIngredient.create(recipe_ingredient_params)
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