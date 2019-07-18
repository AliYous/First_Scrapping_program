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
    email_mairies = Array.new
    tableau_url_mairies = Array.new
    email = ""
    
    tableau_url_mairies = all_townhalls_url.xpath('//a[contains(@class, txtlink)]/@href')
    tableau_url_mairies = tableau_url_mairies.map do |url| 
         url_mairie_instance = url.to_s.sub(".", "http://annuaire-des-mairies.com")
         puts url_mairie_instance
    end

    all_townhalls_url.xpath('//a[contains(@class, txtlink)]').each do |ville|
        nom_ville << ville.text.strip
    end


    puts email_mairies
end

get_townhall_urls(page)

