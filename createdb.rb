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
  String :url
  String :img_url
  
end
DB.create_table! :reviews do
  primary_key :id
  foreign_key :hostel_id
  foreign_key :user_id
  Boolean :recommended
  String :review, text: true
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

hostels_table.insert(title: "Sant Jordi Hostels Sagrada Familia", 
                    description: "Come party with us in our Barcelona skateboarders' paradise at Sant Jordi Sagrada Familia, the first hostel designed around the city's vibrant urban arts and culture scene. Check in at our 24-hour reception, then check out our chill-out room and sing karaoke or play guitar on our skate ramp-inspired stage. Meet new friends in front of our big-screen TV and explore our huge selection of movies, or Skype home with our free Wi-Fi. You can soak up the rays in our large outdoor patio and BBQ area. Whatever you do, you’ll meet travellers from around the world.",
                    address: "Freser,5 , Barcelona, Spain ",
                     city_id: "1",
                     url: " https://www.hostelworld.com/hosteldetails.php/Sant-Jordi-Hostels-Sagrada-Familia/Barcelona/20512?dateFrom=2020-03-06&dateTo=2020-03-07&number_of_guests=1&sc_pos=1 ",
                     img_url: "https://a.hwstatic.com/image/upload/f_auto,q_auto,t_80,c_fill,g_north/v1/propertyimages/1/16784/z0vi2wpuxrnfmoac52ll"                    )

hostels_table.insert(title: "Kabul Party Hostel Barcelona", 
                    description: "If having a ball in Barca's at the top of your agenda, choose Kabul Party Hostel. We're well known around these parts for our lively atmosphere and buzzing parties. We have an on-site bar and several lounge areas where you can chill out during the day, as well as a sunkissed rooftop terrace overlooking the lively Plaça Reial which is in the heart of the action. When you surface from the night before, we'll reward you with a free breakfast. Every day!",
                    address: "Plaza Real 17 , Barcelona, Spain",
                    city_id: "1",
                    url: " https://www.hostelworld.com/hosteldetails.php/Kabul-Party-Hostel-Barcelona/Barcelona/722?dateFrom=2020-03-06&dateTo=2020-03-07&number_of_guests=1&sc_pos=13 ",
                    img_url: " https://a.hwstatic.com/image/upload/f_auto,q_auto,t_80,c_fill,g_north/v1/propertyimages/7/722/qxraaspskoyvunfxsvwl "              )
                    
hostels_table.insert(title: "Hostel One Sants", 
                    description: "Hostel One Sants has a great atmosphere and is an easy place to meet other people. We offer a wide range of activities and special events throughout Barcelona, as well as free entrance to the best clubs in Barcelona. So what are you waiting for! Book now and become part of the Hostel One Family!",
                    address: "Calle Casteras 9 , Barcelona, Spain",
                    city_id: "1",
                    url: " https://www.hostelworld.com/hosteldetails.php/Hostel-One-Sants/Barcelona/16784?dateFrom=2020-03-06&dateTo=2020-03-07&number_of_guests=1&sc_pos=5 ",
                    img_url: " https://a.hwstatic.com/image/upload/f_auto,q_auto,t_80,c_fill,g_north/v1/propertyimages/2/20512/qcart1u7wsxruxnyxsry"                )

hostels_table.insert(title: "Mad Monkey Nacpan Beach", 
                    description: "Featuring an all-native hostel, beach bar, and restaurant, Mad Monkey Hostel Nacpan is your perfect beach (party) escape in the Philippines. Imagine laying on one of the best beaches in the world and hearing the waves crash before you, all while sipping coconuts, drinking ice cold beers, and enjoying woodfire pizzas.",
                    address: "Nacpan Beach,Sitio Calitang, Barangay Bucana, El Nido , El Nido, Philippines",
                    city_id: "2",
                    url: " https://www.hostelworld.com/hosteldetails.php/Mad-Monkey-Nacpan-Beach/El-Nido/282310?dateFrom=2020-03-25&dateTo=2020-03-26&number_of_guests=1&sc_pos=2 ",
                    img_url: "https://a.hwstatic.com/image/upload/f_auto,q_auto,t_80,c_fill,g_north/v1/propertyimages/2/282310/vaao8axwedmfugunkng2 "                    )

hostels_table.insert(title: "Outpost Beach Hostel", 
                    description: "At Outpost Beach Hostel, you'll find a super fun and sociable atmosphere – and some of the most gorgeous sunsets you'll ever see. You can lie back on the sand, go island hopping with your new travel mates or mingle with new people from the world over at the on-site bar (we put on events nearly every night). Our restaurant serves breakfast, lunch and dinner, and we have barbecues every Sunday! We've also got a spacious lounge with a PS3 and Nintendo 64 if you need a break from the sun.",
                    address: "Sitio Lugadia National Highway , El Nido, Philippines",
                    city_id: "2",
                    url: " https://www.hostelworld.com/hosteldetails.php/Outpost-Beach-Hostel/El-Nido/272882?dateFrom=2020-03-25&dateTo=2020-03-26&number_of_guests=1 ",
                    img_url: " https://a.hwstatic.com/image/upload/f_auto,q_auto,t_80,c_fill,g_north/v1/propertyimages/2/272882/vmpmi7iejck9neqkahwe "                 )

hostels_table.insert(title: "Frendz Hostel El Nido", 
                    description: "Eat & Drink - Enjoy great food, drinks, and specialty coffee in our in-house partner restaurant and bar Hub. It's also a perfect place to meet new people while listening to our resident DJs and local artists on selected dates. Travelers and locals are welcome. Sleep - We have a bed for every budget! Find out about our private and shared rooms. Connect - Meet and connect to the Tribe of Frendz. Become part of the tribe and create memories together when exploring the neighborhood and surrounding islands.",
                    address: "Osmena Street, Masagana, 5313 , El Nido, Philippines",
                    city_id: "2",
                    url: " https://www.hostelworld.com/hosteldetails.php/Frendz-Hostel-El-Nido/El-Nido/293897?dateFrom=2020-03-25&dateTo=2020-03-26&number_of_guests=1&sc_pos=1 ",
                    img_url: " https://a.hwstatic.com/image/upload/f_auto,q_auto,t_80,c_fill,g_north/v1/propertyimages/2/293897/lbkuz85esiex0magfysz"                 )

# Insert initial (seed) data
cities_table = DB.from(:cities)

cities_table.insert(name: "Barcelona" ) 

cities_table.insert(name: "El Nido" )