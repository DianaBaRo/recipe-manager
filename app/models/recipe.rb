class Recipe < ApplicationRecord
    belongs_to :user
    has_many :recipe_ingredients
    has_many :ingredients, through: :recipe_ingredients
    
    has_many :recipe_categories
    has_many :categories, through: :recipe_categories
    
    has_many :comments
    has_many :ratings

    validates :name, presence: true
    validates :cooking_time, numericality: { only_integer: true }
    validates :servings, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 20, message: "can't be blank and has to be a number between 1 and 20" }
    validates :directions, presence: true

    def self.by_name(name)
      where(['name LIKE ?', "%#{name}%"])
    end
  
    def self.by_user(user_id)
      where(user: user_id)
    end

end
