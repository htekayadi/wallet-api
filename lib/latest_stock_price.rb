require 'httparty'

class LatestStockPrice
  BASE_URL = 'https://latest-stock-price.p.rapidapi.com'

  def self.price(symbol)
    response = HTTParty.get("#{BASE_URL}/price", query: { symbol: symbol }, headers: headers)
    parse_response(response)
  end

  def self.prices(symbols)
    response = HTTParty.get("#{BASE_URL}/prices", query: { symbols: symbols.join(',') }, headers: headers)
    parse_response(response)
  end

  def self.price_all
    response = HTTParty.get("#{BASE_URL}/price_all", headers: headers)
    parse_response(response)
  end

  private

  def self.headers
    {
      'X-RapidAPI-Key' => ENV['RAPIDAPI_KEY'],
      'X-RapidAPI-Host' => 'latest-stock-price.p.rapidapi.com'
    }
  end

  def self.parse_response(response)
    JSON.parse(response.body)
  end
end