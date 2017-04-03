class Movie < ApplicationRecord
  validates :name,:film_type,:film_time, presence: true

  belongs_to :user
  has_many :reviews

  has_many :favorites
  has_many :movie_members, through: :favorites, source: :user    
end
