class CreateHoldings < ActiveRecord::Migration[7.1]
  def change
    create_table :holdings do |t|
      t.string :ticker
      t.float :shares
      t.references :portfolio, null: false, foreign_key: true

      t.timestamps
    end
  end
end
