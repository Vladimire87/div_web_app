class Holding < ApplicationRecord
  belongs_to :portfolio
  validates_presence_of :portfolio
end
