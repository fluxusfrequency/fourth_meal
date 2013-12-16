# The data:
# At least 10,000 restaurants
# Broken into 30 regions
# At least 20 items per restaurant
# At least 3 categories per restaurant
# 100,000 users
# 2 restaurant admins per restaurant
# 2 stockers per restaurant
# 2 platform administrators

# require 'benchmark'

# time = Benchmark.measure do 

  # CITIES

  denver = Location.create(city: "Denver")
  dc = Location.create(city: "Washington, D.C.")
  nyc = Location.create(city: "New York City")
  atlanta = Location.create(city: "Atlanta")
  philadelphia = Location.create(city: "Philadelphia")

  pittsburgh = Location.create(city: "Pittsburgh")
  boston = Location.create(city: "Boston")
  charlotte = Location.create(city: "Charlotte")
  miami = Location.create(city: "Miami")
  burlington = Location.create(city: "Burlington")

  baltimore = Location.create(city: "Baltimore")
  minneapolis = Location.create(city: "Minneapolis")
  chicago = Location.create(city: "Chicago")
  madison = Location.create(city: "Madison")
  cincinnati = Location.create(city: "Cincinatti")

  albuquerque = Location.create(city: "Albuquerque")
  santa_fe = Location.create(city: "Santa Fe")
  colorado_springs = Location.create(city: "Colorado Springs")
  boulder = Location.create(city: "Boulder")
  slc = Location.create(city: "Salt Lake City")

  austin = Location.create(city: "Austin")
  dallas = Location.create(city: "Dallas")
  seattle = Location.create(city: "Seattle")
  portland = Location.create(city: "Portland")
  la = Location.create(city: "Los Angeles")

  sf = Location.create(city: "San Francisco")
  san_diego = Location.create(city: "San Diego")
  honolulu = Location.create(city: "Honolulu")
  anchorage = Location.create(city: "Anchorage")
  detroit = Location.create(city: "Detriot")

  cities = [denver, dc, nyc, atlanta, philadelphia,
            pittsburgh, boston, charlotte, miami, burlington,
            baltimore, minneapolis, chicago, madison, cincinnati,
            albuquerque, santa_fe, colorado_springs, boulder, slc,
            austin, dallas, seattle, portland, la,
            sf, san_diego, honolulu, anchorage, detroit]

  # RESTAURANTS

  #approved
  ono = Restaurant.create(name: "Ono Burrito", description: "Yummy Burros", slug: "ono-burrito", status: "approved", location_id: denver.id, theme: "application", active: true)
  billy = Restaurant.create(name: "Billy's BBQ", description: "Fingerlickin' Chickin'", slug: "billys-bbq", status: "approved", location_id: dc.id, theme: "application", active: true)
  adam = Restaurant.create(name: "Adam's Pizza", description: "Ummm...I made you a pizza?", slug: "adams-pizza", status: "approved", location_id: nyc.id, theme: "dark", active: true)
  ben = Restaurant.create(name: "Ben's Beer", description: "Good Head!", slug: "bens-beer", status: "approved", location_id: atlanta.id, theme: "light", active: true)
  taste_of_india = Restaurant.create(name: "Taste of India", description: "Delicacies from India", slug: "taste-of-india", status: "approved", theme: "solarized", location_id: philadelphia.id, active: true)

  #offline
  le_central = Restaurant.create(name: "Le Central", description: "High Brow Cuisine", slug: "le-central", status: "approved", location_id: pittsburgh.id, active: false)

  #pending
  parsley = Restaurant.create(name: "Parsley", description: "Hippie Food", slug: "parsley", status: "pending", location_id: boston.id, active: false)
  gorgonzola = Restaurant.create(name: "Gorgonzola", description: "Cheese Boards Deluxe", slug: "gorgonzola", status: "pending", location_id: charlotte.id, active: false)

  #rejected
  coltandgray = Restaurant.create(name: "Colt and Gray", description: "We Use It All...Yes, Even The Brains", slug: "colt-and-gray", status: "rejected", location_id: miami.id, active: false)
  englishtea = Restaurant.create(name: "English Tea House", description: "Tea Time!!!", slug: "english-tea-house", status: "rejected", location_id: burlington.id, active: false)

  restaurants = [ono, billy, adam, ben, taste_of_india, le_central, parsley, gorgonzola, coltandgray, englishtea]

  def clone_restaurant(restaurant, locations, count)
    count.times do |i|
      puts "creating restaurant #{restaurant.name} #{i}..."
      r = restaurant.dup
      r.update(
        name: restaurant.name + "#{i}",
        status: restaurant.status,
        slug: restaurant.slug + "#{i}",
        location: locations[rand(30)])
    end
  end

  restaurants.each {|r| clone_restaurant(r, cities, 10) }
  #restaurants.each {|r| clone_restaurant(r, cities, 1000) }








  # USERS

  frank = User.create(email: "demo+franklin@jumpstartlab.com", 
    full_name: "Franklin Webber", 
    display_name: "burtlo", 
    password: "password",
    password_confirmation: "password",
    :super => true)

  jeff = User.create(email: "demo+jeff@jumpstartlab.com", 
    full_name: "Jeff", 
    display_name: "j3",
    password: "password",
    password_confirmation: "password",
    :super => true)

  katrina = User.create(email: "demo+katrina@jumpstartlab.com", 
    full_name: "Katrina Owen", 
    display_name: "kytrynx", 
    password: "password",
    password_confirmation: "password",
    :super => true)

  benny = User.create(email: "bennlewis@gmail.com", 
    full_name: "Ben Lewis", 
    display_name: "bennybeans", 
    password: "password",
    password_confirmation: "password")

  billyo = User.create(email: "navyosu@gmail.com", 
    full_name: "Billy G", 
    display_name: "billybeans", 
    password: "password",
    password_confirmation: "password")

  addy = User.create(email: "adam.dev89@gmail.com", 
    full_name: "Adam", 
    display_name: "addybeans", 
    password: "password",
    password_confirmation: "password")

  def seed_users(count)
    count.times do |i|
      puts "Creating user #{i}"
      User.create(
        full_name: "user_number_#{i}",
        display_name: "user_#{i}",
        email: "user_#{i}@example.com",
        password: "password",
        password_confirmation: "password")
    end
  end

  #seed_users(100000)
  seed_users(100)




  # RESTAURANT USERS

  def seed_restaurant_users(rest_id, role, count)
    unless ['customer', 'employee', 'owner'].include?(role)
      throw ArgumentError "Role must be customer, employee, or owner" 
    end

    count.times do |i|
      begin 
        puts "Seeding #{role} number #{i} for restaurant #{rest_id}..."
        RestaurantUser.create(
          restaurant_id: rest_id,
          user_id: rand(@user_count),
          role: role)
      rescue
        puts "Failed to create role! Trying again..."
        retry
      end
    end
  end

  @user_count = User.all.count
  @rest_count = Restaurant.all.count

  @rest_count.times do |i| 
    seed_restaurant_users(i, "employee", 2)
    seed_restaurant_users(i, "owner", 2)
  end



  # ITEMS

  def seed_items(restaurant, menu, adjectives, count)
    count.times do |i|
      begin
        puts "Seeding item number #{i} for #{restaurant.name}..."
        title = menu[rand(5)] + "_#{i}"
        desc = "#{title}. Oh so #{adjectives[rand(5)]}!"
        item = restaurant.items.create(item_params(title, desc, restaurant))
      rescue
        # binding.pry
        # puts "Item failed to create! Trying again..."
        retry
      end
    end
  end

  def item_params(title, desc, restaurant)
    if Rails.env == "production"
      {
        title: title,
        description: desc,
        price: rand(20) + 1,
        photo_file_name: "seed/#{restaurant.slug.gsub(/\d+/, "")}/#{rand(5) + 1}.jpg",
        retired: false,
        restaurant_id: restaurant.id
      }
    else
      {
        title: title,
        description: desc,
        price: rand(20) + 1,
        photo: File.open("app/assets/images/seed/#{restaurant.slug.gsub(/\d+/, "")}/#{rand(5) + 1}.jpg", 'r'),
        retired: false,
        restaurant_id: restaurant.id
      }
    end
  end


  restaurants = [ono, billy, adam, ben, taste_of_india, le_central, parsley, gorgonzola, coltandgray, englishtea]
  ono_menu = ["Taco Gumbo", "Steak Burrito", "Breakfast Burrito", "Taco Salad", "Signature Vegetable Burrito"]
  billy_menu = ["Pulled Pork", "Braised Ribs", "Chitlins", "BBQ Pork", "Cook's Favorite"]
  adam_menu = ["Pepperoni Pizza", "Deep Dish Pie", "Calzone", "Chef's Pizza", "Veggie Special"]
  ben_menu = ["India Pale Ale", "Signature Red Ale", "Guiness", "English Stout", "PBR"]
  taste_menu = ["Madras Sanbar", "Naan", "Saag Paneer", "Aloo Chat", "Aloo Gobi"]
  le_central_menu = ["Foie Gras", "Le Buche de Noel", "Salade Perigourdine", "Goose of the Week", "Oie Normande"]
  parsley_menu = ["Tree Hugger", "Parsley Salad", "Tofu Delight", "Light Faire", "Daily Special"]
  gorgonzola_menu = ["Gorgonzola Plate", "Brie Plate", "Specialty Plate", "Camembere Plate", "Gouda Plate"]
  colt_menu = ["Peameal Bacon", "Braunschweiger", "Shropshire Blue Cheddar", "Local Duroc Pork Brains", "Toasted Oat Farfalle"]
  englishtea_menu = ["Kensington", "Wimbledon", "Covent Garden", "Ploughman's Lunch", "Earl Grey Platter"]

  menu_lookup = { ono.slug => ono_menu, 
                  billy.slug => billy_menu,
                  adam.slug => adam_menu,
                  ben.slug => ben_menu,
                  taste_of_india.slug => taste_menu,
                  le_central.slug => le_central_menu,
                  parsley.slug => parsley_menu,
                  gorgonzola.slug => gorgonzola_menu,
                  coltandgray.slug => colt_menu,
                  englishtea.slug => englishtea_menu}

  superlatives = ["great", "delicious", "moutwatering", "classy", "appetizing"]

  Restaurant.all.each { |rest| seed_items(rest, menu_lookup[rest.slug.gsub(/\d+/, "")], superlatives, 5) }




  # CATEGORIES

  cats = ["Entrees", "Appetizers", "Dessert", "Beverages", "Specialties", 
    "Apéritifs", "Digestifs", "Vegetarian", "Salads", "Kids Menu"]

  def seed_categories(restaurant, categories, count)
    count.times do |i|
      begin
        puts "Creating category #{i} for #{restaurant.name}..."
        category = categories[i]
        restaurant.categories.create(title: category,
                                    restaurant_id: restaurant.id)
      rescue
        # binding.pry
        puts "Category already exists! Trying again..."
        retry
      end
    end
  end

  Restaurant.all.each { |rest| seed_categories(rest, cats, 5) }




  # ITEM CATEGORIES

  def seed_item_categories(restaurant, count)
    count.times do |i|
      begin
        puts "Seeding item category ##{i} for #{restaurant.name}..."
        item_id = restaurant.items[i - 1].id
        category_id = restaurant.categories[rand(5)].id
        ItemCategory.create!( item_id: item_id,
                              category_id: category_id)
      rescue
        # binding.pry
        puts "Item category failed to create! Trying again..."
        retry
      end
    end
  end

  Restaurant.all.each do |rest| 
    @count ||= rest.items.size
    seed_item_categories(rest, @count)
  end


# end

# puts "Time to seed:"
# puts time
