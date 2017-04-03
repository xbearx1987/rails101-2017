class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :groups
  has_many :posts

  has_many :movies
  has_many :reviews

  has_many :group_relationships
  has_many :participated_groups, :through => :group_relationships, :source => :group

  def is_member_of?(group)
    participated_groups.include?(group)
  end

  def join!(group)
    participated_groups << group
  end

  def quit!(group)
    participated_groups.delete(group)
  end

  has_many :favorites
  has_many :participated_favorites, :through => :favorites, :source => :movie

  def is_movie_member_of?(movie)
    participated_favorites.include?(movie)
  end

  def add_favorite!(movie)
    participated_favorites << movie
  end

  def remove_favorite!(movie)
    participated_favorites.delete(movie)
  end
end
