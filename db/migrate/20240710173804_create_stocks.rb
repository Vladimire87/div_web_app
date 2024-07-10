class CreateStocks < ActiveRecord::Migration[7.1]
  def change
    create_table :stocks do |t|
      t.string :ticker
      t.string :name
      t.float :current_price
      t.datetime :last_price_update
      t.datetime :last_dividend_update

      t.timestamps
    end
  end
end
