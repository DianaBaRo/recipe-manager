class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :content, presence: true

  def self.by_user(user_id)
    where(user: user_id)
  end

  def self.by_recipe(recipe_id)
    where(recipe_id: recipe_id)
  end 
end
