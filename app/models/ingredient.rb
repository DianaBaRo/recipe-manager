class Ingredient < ApplicationRecord
    has_many :recipe_ingredients
    has_many :recipes, through: :recipe_ingredients

    validates :name, presence: true, uniqueness: {message: "Please, %{value} should be unique per recipe"}
    validates :name, presence: true
end
