#Initialize everything we need 
require 'rubygems'
require 'nokogiri'   
require 'open-uri'
PAGE_URL = "https://coinmarketcap.com/all/views/all/"
page = Nokogiri::HTML(open(PAGE_URL))  


def scraping(page)
    # Scraping des symboles de cryptos
    currencies_scrap = page.xpath('//td[contains(concat(" ",normalize-space(@class)," "), " col-symbol ")]')
    currencies = currencies_scrap.map { |currency| currency.text.strip }
    # Scraping des valeurs de cryptos 
  
    values = values_scrap.map { |value| value.text.delete("$").to_f }
    # Regroupement des deux arrays en un hash
    h = Hash[currencies.zip(values)]
    # Segmentation du hash en plusieurs hashes au sein d'un array
    result = [h.each {|k,v| Hash[k => v] }]
  
end

def scraping(page)

    price_scrap = Array.new
    symbol_scrap = Array.new

    page.xpath('//a[contains(@class, "price")]').each do |node|
        price_scrap << node.text.delete("$").to_f
    end

    page.xpath('//td[contains(@class, "text-left col-symbol")]').each do |node|
        symbol_scrap << node.text
    end
    
    symbol_value_pair = Hash[symbol_scrap.zip(price_scrap)]
    result = [symbol_value_pair.each {|k,v| Hash[k => v] }]

    puts result
end

scraping(page)

