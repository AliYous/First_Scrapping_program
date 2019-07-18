#frozen_string_literal: true.
#Initialize everything we need 
require 'rubygems'
require 'nokogiri'   
require 'open-uri'

PAGE_URL = "http://annuaire-des-mairies.com/val-d-oise.html"
page = Nokogiri::HTML(open(PAGE_URL)) 
townhall_url = Nokogiri::HTML(open("https://annuaire-des-mairies.com/95/fremainville.html")) 


#-----------------------------------------------------------------------------------------------------#

# Toutes les méthodes fonctionnent indépendamment mais j'ai des erreurs au moment de les imbriquer ensembles. 
# 'Xpath undefined for string' Le problème vient surement du fait que je cherche à appliquer .xpath sur un string, 
# J'ai essayé beaucoup de choses et je n'ai pas trouvé la solution

#-----------------------------------------------------------------------------------------------------#



#Prend en paramètre l'URL d'une mairie et retourne son adresse mail en string
def get_townhall_email(townhall_url)
    return townhall_url.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
end

#retourne le nom d'une ville en string
def get_city_name(townhall_url)
    city_name = townhall_url.xpath('/html/body/div/main/section[1]/div/div/div/h1').text
    city_name = city_name.capitalize.split.take(1) #Pour capitaliser le nom et se débarasser du Code Post.
    return city_name
end


#Retourne un tableau (strings) contenant les url de chaque villes
def get_city_urls(page)
    # ------- Initialisation Variable -------- 
    tableau_url_incompletes = []
    
    #---------Va chercher le lien vers chaque ville sous la forme .95/ville------
    tableau_url_incompletes_raw = page.xpath('//a[contains(@class, txtlink)]/@href')

    # Supprime les href qui ne commencent pas par un "." (ne sont pas des url vers des mairies)
    tableau_url_incompletes_raw.each do |url|
      url_temp = url
      if url_temp.to_s.start_with?(".") == true
        tableau_url_incompletes << url
      end
    end

    #-----Modifie les liens pour les transformer en URL accessible (enlève le point puis ajoute la première partie de l'url)----
    tableau_url_completes = tableau_url_incompletes.map do |url|
      url.to_s.sub(".", "http://annuaire-des-mairies.com")
    end

    return tableau_url_completes
end

def get_city_name_all_townhalls(tableau_url_completes)
  city_names = []
  tableau_url_completes.each do |url|
    city_names << get_city_name(url)
  end
  return city_names
end


# Returns a hash of emails {(nom_ville => email)}
def get_emails_all_townhalls(tableau_url_completes)
  email_townhalls = []
  tableau_url_completes.each do |url|
    email_townhalls << get_townhall_email(url)
  end
end

puts get_city_urls(page)