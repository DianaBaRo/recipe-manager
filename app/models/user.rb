class User < ApplicationRecord
    has_many :recipes
    has_many :comments
    has_many :ratings

end
