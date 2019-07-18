#Initialize everything we need 
require 'rubygems'
require 'nokogiri'   
require 'open-uri'
PAGE_URL = "http://annuaire-des-mairies.com/val-d-oise.html"
page = Nokogiri::HTML(open(PAGE_URL))  


#Prend en paramètre l'URL d'une mairie et retourne son adresse mail
def get_townhall_email(townhall_url)
    return townhall_url.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')
end

def get_townhall_urls(all_townhalls_url)
    nom_ville = Array.new
    email_mairie = Array.new
    
    all_townhalls_url.xpath('//a[contains(@class, txtlink)]/@href').each do |url|
        email_mairie << get_townhall_email("http://annuaire-des-mairies.com/#{url.to_s.delete_prefix(".")}")
    end

    all_townhalls_url.xpath('//a[contains(@class, txtlink)]').each do |ville|
        nom_ville << ville.text.strip
    end

    puts nom_ville
    puts email_mairie
end

get_townhall_urls(page)
