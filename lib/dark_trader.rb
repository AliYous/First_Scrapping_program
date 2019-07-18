#Initialize everything we need 
require 'rubygems'
require 'nokogiri'   
require 'open-uri'
PAGE_URL = "https://coinmarketcap.com/all/views/all/"
page = Nokogiri::HTML(open(PAGE_URL))  


def scraping(page)

    price_scrap = Array.new
    symbol_scrap = Array.new

    page.xpath('//a[contains(@class, "price")]').each do |elem|
        price_scrap << elem.text.delete("$").to_f
    end

    page.xpath('//td[contains(@class, "text-left col-symbol")]').each do |elem|
        symbol_scrap << elem.text
    end
    
    symbol_value_pair = Hash[symbol_scrap.zip(price_scrap)]
    result = [symbol_value_pair.each {|k,v| Hash[k => v] }]

    puts result
end

scraping(page)

