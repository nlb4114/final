# Set up for the application and database. DO NOT CHANGE. #############################
require "sinatra"                                                                     #
require "sinatra/reloader" if development?                                            #
require "geocoder"                                                                    # added
require "sequel"                                                                      #
require "logger"                                                                      #
require "twilio-ruby"                                                                 #
require "bcrypt"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB ||= Sequel.connect(connection_string)                                              #
DB.loggers << Logger.new($stdout) unless DB.loggers.size > 0                          #
def view(template); erb template.to_sym; end                                          #
use Rack::Session::Cookie, key: 'rack.session', path: '/', secret: 'secret'           #
before { puts; puts "--------------- NEW REQUEST ---------------"; puts }             #
after { puts; }                                                                       #
#######################################################################################

hostels_table = DB.from(:hostels)
reviews_table = DB.from(:reviews)
users_table = DB.from(:users)
cities_table = DB.from(:cities)


before do
    @current_user = users_table.where(id: session["user_id"]).to_a[0]
end

get "/" do
    puts cities_table.all
    @cities = cities_table.all.to_a
    view "cities"
end

get "/cities/:id" do
    puts cities_table.all
    @city = cities_table.where(id: params[:id]).to_a[0]
    @hostels = hostels_table.where(city_id: @city[:id])

    results = Geocoder.search( @city[:name] )
        lat_long = results.first.coordinates
        @lat = lat_long[0]
        @long = lat_long[1]
        @lat_long = "#{@lat},#{@long}"

    view "city"
end

get "/hostels/:id" do
    @hostel = hostels_table.where(id: params[:id]).to_a[0]
    @reviews = reviews_table.where(hostel_id: @hostel[:id])
    @recommend_count = reviews_table.where(hostel_id: @hostel[:id]).sum(:recommended)
    @users_table = users_table
    view "hostel"
end

get "/hostels/:id/reviews/new" do
    @hostel = hostels_table.where(id: params[:id]).to_a[0]
    view "new_review"
end

get "/hostels/:id/reviews/create" do
    puts params
    @hostel = hostels_table.where(id: params[:id]).to_a[0]
    reviews_table.insert(hostel_id: params["id"],
                        user_id: session["user_id"],
                        recommended: params["recommended"],
                        review: params["review"])
    view "create_review"
end



#Everything Below is in regards to user creation and log-in
get "/users/new" do
    view "new_user"
end

get "/users/create" do
    puts params
    users_table.insert(name: params["name"],
                        email: params["email"],
                        password: BCrypt::Password.create(params["password"]))
    view "create_user"
end

get "/logins/new" do
    view "new_login"
end

post "/logins/create" do
    puts params
    email_address = params["email"]
    password = params["password"]

    @user = users_table.where(email: email_address).to_a[0]

    if @user
        if BCrypt::Password.new(@user[:password]) == password
            session["user_id"] = @user[:id]
            view "create_login"
        else
            view "create_login_failed"
        end
    else
        view "create_login_failed"
    end

    
end

get "/logout" do
    session["user_id"] = nil
    view "logout"
end