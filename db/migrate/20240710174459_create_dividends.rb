# frozen_string_literal: true

class CreateDividends < ActiveRecord::Migration[7.1]
  def change
    create_table :dividends do |t|
      t.references :stock, null: false, foreign_key: true
      t.date :ex_dividend_date
      t.date :payment_date
      t.float :amount
      t.string :frequency

      t.timestamps
    end
  end
end
