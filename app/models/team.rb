class Team < ApplicationRecord
  has_many :goals, dependent: :destroy
  has_and_belongs_to_many :tournaments
  has_and_belongs_to_many :groups

  validates :name, presence: true

  attr_accessor :rank
end
