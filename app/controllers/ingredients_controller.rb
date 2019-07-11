class IngredientsController < ApplicationController
    before_action :require_login
    
    def new
      @ingredient = Ingredient.new
    end
  
    def create
      @ingredient = Ingredient.create(ingredient_params)
      if @ingredient.save
        redirect_to recipes_path
      else
        render :new
      end
    end

    private
    def ingredient_params
      params.require(:ingredient).permit(:name, recipe_ingredient_attributes: [:recipe_id, :ingredient_id, :quantity] )
    end
  
  end