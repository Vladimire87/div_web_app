# frozen_string_literal: true

class Holding < ApplicationRecord
  belongs_to :portfolio
  belongs_to :stock
  validates_presence_of :portfolio

  attr_accessor :ticker

  before_validation :assign_stock

  private

  def assign_stock
    self.stock = Stock.find_or_create_by(ticker: ticker.upcase)
  end
end
