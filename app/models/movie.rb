class Movie < ApplicationRecord
  validates :name,:film_type,:film_time, presence: true

  belongs_to :user
  has_many :reviews
end
