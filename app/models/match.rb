class Match < ApplicationRecord
  has_many :goals
  belongs_to :tournament
  belongs_to :group
end
