class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  validates :quantity, numericality: { only_integer: true }
  validates :ingredient_id, uniqueness: { scope: :recipe_id, message: "should be unique per recipe"}
   
end
