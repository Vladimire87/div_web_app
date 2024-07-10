class UpdateStocksJob < ApplicationJob
  queue_as :default

  def perform
    Stock.find_each.with_index do |stock, index|
      stock.update_data_from_polygon
      stock.update_dividends_from_polygon
      sleep 12 if (index + 1) % 5 == 0 # Пауза после каждых 5 запросов
    end
  end
end
