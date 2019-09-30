class Tournament < ApplicationRecord
  has_many :groups
  has_many :matches
  has_and_belongs_to_many :teams
end
