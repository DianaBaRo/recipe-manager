class RecipeCategory < ApplicationRecord
  belongs_to :recipe
  belongs_to :category

  validates :category_id, uniqueness: { scope: :recipe_id, message: "should have one type of category per recipe"}
end
