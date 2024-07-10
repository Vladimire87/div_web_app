# frozen_string_literal: true

# app/services/polygon_service.rb
require 'net/http'
require 'json'

class PolygonService
  BASE_URL = 'https://api.polygon.io/v3'
  API_KEY = Rails.application.credentials.polygon[:api_key]

  def self.fetch_stock_data(ticker)
    uri = URI("#{BASE_URL}/aggs/ticker/#{ticker}/prev?apiKey=#{API_KEY}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def self.fetch_dividends(ticker)
    uri = URI("#{BASE_URL}/reference/dividends/#{ticker}?apiKey=#{API_KEY}")
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def self.update_stock_data(ticker)
    uri = URI("#{BASE_URL}/reference/tickers/#{ticker}?apiKey=#{API_KEY}")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri)
    response = http.request(request)

    JSON.parse(response.body)
  end
end
