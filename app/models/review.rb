class Review < ApplicationRecord
  validates :content, presence: true

  belongs_to :movie
  belongs_to :user

  scope :recent, -> { order("created_at desc")}
end
