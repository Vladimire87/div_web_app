# frozen_string_literal: true

class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :holdings, inverse_of: :portfolio, dependent: :destroy
  has_many :stocks, through: :holdings
  accepts_nested_attributes_for :holdings, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true
end
