class Recipe < ApplicationRecord
    belongs_to :user
    has_many :recipe_ingredients
    has_many :ingredients, through: :recipe_ingredients
    accepts_nested_attributes_for :ingredients #create ingredients_attributes method
    accepts_nested_attributes_for :recipe_ingredients #create recipe_ingredients_attributes method
    has_many :recipe_categories
    has_many :categories, through: :recipe_categories
    accepts_nested_attributes_for :categories #create categories_attributes method
    accepts_nested_attributes_for :recipe_categories #create recipe_categories_attributes method
    has_many :comments
    has_many :ratings


    validates :name, presence: true
    validates :cooking_time, numericality: { only_integer: true }
    validates :servings, numericality: { only_integer: true }
    validates :directions, presence: true

    def delete_ingredients_from_recipe
      ingredients.size.times do
        ingredient = RecipeIngredient.find_by(recipe_id: self.id)
        ingredient.delete
      end
    end

    def add_ingredients_to_recipe(params)

      delete_ingredients_from_recipe

      if params[:recipe_ingredients_attributes]
      
        params[:recipe_ingredients_attributes].each do |k, recipe_ingredient|
    
          if recipe_ingredient[:ingredient][:name].present?
            ingredient_name = recipe_ingredient[:ingredient][:name].downcase
            ingredient = Ingredient.find_or_create_by(name: ingredient_name)
              
          elsif recipe_ingredient[:ingredient_id].present?
            ingredient = Ingredient.find_by(id: recipe_ingredient[:ingredient_id])
          end

          if recipe_ingredient[:quantity].present? && ingredient
            RecipeIngredient.create(quantity: recipe_ingredient[:quantity], ingredient_id: ingredient.id, recipe_id: self.id )
          end

        end
      end
    end

    def delete_categories_from_recipe
      categories.size.times do
        category = RecipeCategory.find_by(recipe_id: self.id)
        category.delete
      end
    end

    def add_categories_to_recipe(params)

      delete_categories_from_recipe

      if params[:recipe_categories_attributes]
      
        params[:recipe_categories_attributes].each do |k, recipe_category|
    
          if recipe_category[:category][:name].present?
            category_name = recipe_category[:category][:name].downcase
            category = Category.find_or_create_by(name: category_name)
              
          elsif recipe_category[:category_id].present?
            category = Category.find_by(id: recipe_category[:category_id])
          end

          if category
            RecipeCategory.create(category_id: category.id, recipe_id: self.id )
          end

        end
      end
    end

    def self.by_name(name)
      where(['name LIKE ?', "%#{name}%"])
    end
  
    def self.by_user(user_id)
      where(user: user_id)
    end

end
