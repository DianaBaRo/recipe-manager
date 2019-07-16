class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  accepts_nested_attributes_for :ingredient

  validates :quantity, numericality: { only_integer: true, message: "should be added and should be a number" }
  validates :ingredient_id, uniqueness: { scope: :recipe_id, message: "should be unique per recipe"}

end
