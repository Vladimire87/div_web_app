# frozen_string_literal: true

class Stock < ApplicationRecord
  has_many :holdings
  has_many :portfolios, through: :holdings
  has_many :dividends

  def update_data_from_polygon
    data = PolygonService.fetch_stock_data(self.ticker)
    if data['resultsCount'] > 0
      self.update(
        current_price: data['results'][0]['c'],
        last_price_update: Time.now
      )
    end
  end

  def update_dividends_from_polygon
    data = PolygonService.fetch_dividends(self.ticker)
    if data['status'] == 'OK'
      data['results'].each do |div|
        self.dividends.find_or_create_by(ex_dividend_date: div['exDate']) do |dividend|
          dividend.payment_date = div['paymentDate']
          dividend.amount = div['amount']
          dividend.frequency = div['frequency']
        end
      end
      self.update(last_dividend_update: Time.now)
    end
  end
end
