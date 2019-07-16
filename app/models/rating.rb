class Rating < ApplicationRecord
    belongs_to :user
    belongs_to :recipe

    validates :score, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5, message: "shouldn't be blank and should be a number between 1 and 5" }
    validates :user_id, uniqueness: { scope: :recipe_id, message: "you can make one rating per recipe"}
end