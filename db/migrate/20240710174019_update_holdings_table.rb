# frozen_string_literal: true

class UpdateHoldingsTable < ActiveRecord::Migration[7.1]
  def change
    add_reference :holdings, :stock, foreign_key: true
    add_column :holdings, :average_buy_price, :float
    remove_column :holdings, :ticker, :string
  end
end
