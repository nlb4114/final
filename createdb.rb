# Set up for the application and database. DO NOT CHANGE. ##############
require "sequel"                                                       #
DB = Sequel.connect "sqlite://#{Dir.pwd}/development.sqlite3"          #
########################################################################  

# Database schema - this should reflect your domain model

# New domain model - adds users
DB.create_table! :hostels do
  primary_key :id
  foreign_key :city_id
  String :title
  String :description, text: true
  String :address
  
end
DB.create_table! :reviews do
  primary_key :id
  foreign_key :hostel_id
  foreign_key :user_id
  Boolean :going
  String :comments, text: true
end
DB.create_table! :users do
  primary_key :id
  String :name
  String :email
  String :password
end
DB.create_table! :cities do
  primary_key :id
  String :name
  
end

# Insert initial (seed) data
hostels_table = DB.from(:hostels)

hostels_table.insert(title: "Sant Jordi", 
                    description: "another one",
                    address: "some address",
                     city_id: "1"                    )

hostels_table.insert(title: "Kabul", 
                    description: "Party Hostel in Barecelona",
                    address: "some address",
                    city_id: "1"                )

                    hostels_table.insert(title: "Mad Monkey", 
                    description: "El Nido's second best",
                    address: "some address",
                     city_id: "2"                    )

hostels_table.insert(title: "Outpost", 
                    description: "Party Hostel in El Nido",
                    address: "some address",
                    city_id: "2"                )

# Insert initial (seed) data
cities_table = DB.from(:cities)

cities_table.insert(name: "Barcelona" ) 

cities_table.insert(name: "El Nido" )