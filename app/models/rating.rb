class Rating < ApplicationRecord
    belongs_to :user
    belongs_to :recipe

    validates :score, numericality: { only_integer: true, :in => 1..5 }
    validates :user_id, uniqueness: { scope: :recipe_id, message: "you can make one rating per recipe"}
end