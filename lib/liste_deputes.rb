#frozen_string_literal: true.
#Initialize everything we need 
require 'rubygems'
require 'nokogiri'   
require 'open-uri'
require 'watir'

PAGE_URL = "https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=600"
page = Nokogiri::HTML(open(PAGE_URL)) 


def get_name(name)
	return name
end

def get_surname(surname)
	return surname
end

def get_depute_email(page)
	email_array = []
	name_array = []
	surname_array = []
	name_array_raw = []

	#rempli le tableau de tous les emails des députés
	page.css("li a.ann_mail").each do |elem|
		if elem['href'].to_s.include?("@assemblee-nationale.fr")
			email_array << elem['href'].to_s.sub("mailto:", "")
		end
	end
	return email_array
end

def get_depute_name_and_surname(email_array)
	name_array = []
	surname_array = []
	name_array_raw = []

	#Parcours l'email array et récumère le nom et prénom (avant le @)
	email_array.each do |email|
		name_array_raw << email.sub("@assemblee-nationale.fr", "")
	end

	#Sépare le nom et prénom et stock dans deux arrays
	name_array_raw.each do |elem|
		name = elem.split(".")
		surname_array << name[0]
		name_array << name[1]
	end

	return surname_array.zip(name_array, email_array)
end


def perform(page)
email_arr = get_depute_email(page)
all_info_arr = get_depute_name_and_surname(email_arr)
p all_info_arr
end

perform(page)